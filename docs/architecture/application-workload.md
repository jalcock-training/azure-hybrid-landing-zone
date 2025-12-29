# Application Workload Architecture

This document describes the application workload deployed in the Azure Hybrid Landing Zone.  
The workload demonstrates secure‑by‑default deployment patterns using App Service, Storage, managed identities, and private connectivity.

For related documentation, see:
- `/docs/architecture/hub-and-spoke-network.md`
- `/docs/security/security-overview.md`
- `/docs/architecture/shared-services.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Purpose of the Application Workload

The workload demonstrates how cloud‑native applications can be deployed securely within the landing zone using:

- Private connectivity  
- Managed identities  
- Platform services with secure defaults  
- Consistent governance and tagging  
- Controlled administrative access  

The design is intentionally minimal to support low‑cost operation while still reflecting enterprise‑aligned workload patterns.

---

## 2. Workload Components

The workload consists of the following components:

### **App Service**
A web application hosted on Azure App Service.

### **Storage Account**
Used for application data, static content, or logs.

### **Managed Identity**
Used by the application to access platform services such as Key Vault and Storage.

### **Private Endpoints**
Used to ensure platform services are accessed over private IPs.

### **Private DNS Zones**
Used to resolve private endpoint hostnames from within the hub and spoke networks.

---

## 3. App Service Architecture

The App Service is deployed with secure defaults.

### Current configuration

- Supports **private endpoint integration**  
- Public access can be disabled  
- Uses a **system‑assigned managed identity**  
- Access to Key Vault is via RBAC  
- Access to Storage is via identity or SAS depending on workload needs  
- TLS enforced  

### Future enhancements

- Private endpoint enabled by default  
- App Service Environment (ASE) integration  
- Application Insights for monitoring  
- Multiple deployment slots  
- CI/CD integration for application code  

---

## 4. Storage Architecture

The workload storage account is deployed with secure‑by‑default settings.

### Current configuration

- **Private endpoint enabled**  
- **Private DNS zone linked**  
- **Public network access disabled**  
- **TLS enforced**  
- Identity‑based access supported  
- Standard redundancy to minimise cost  

### Usage

- Application data  
- Static content  
- Logs (optional)  
- Future workload expansion  

---

## 5. Identity and Access

The workload uses a **system‑assigned managed identity** for secure access to platform services.

### Current identity flows

- App Service → Key Vault (RBAC)  
- App Service → Storage (identity or SAS)  
- No long‑lived secrets  
- No service principals with stored credentials  

### Future enhancements

- User‑assigned managed identities  
- Key Vault certificate integration  
- Identity‑based access to additional services  

---

## 6. Administrative Access Flow

Administrative access to workload resources follows the same secure, identity‑centric pattern as the rest of the environment.

### Access chain

1. **Operator authentication**  
   - Azure CLI using OIDC‑based or identity‑based credentials  
   - MFA enforced at the identity provider level

2. **Jump‑ACI**  
   - Ephemeral container  
   - No inbound public ports  
   - Outbound‑only connectivity

3. **Jumphost VM**  
   - Required for interactive administration  
   - Located in the hub network  
   - Currently accessed using a generic account with shared keys  
   - Roadmap: named accounts with MFA

4. **Workload resources**  
   - Accessed from the jumphost VM  
   - Protected by NSGs and private endpoints  
   - No direct inbound access from the internet  

---

## 7. Monitoring and Diagnostics

Monitoring is optional in this phase.

### When enabled:

- App Service diagnostic logs  
- Storage diagnostic logs  
- NSG flow logs  
- Log Analytics workspace integration  

### Not yet implemented:

- Application Insights  
- Distributed tracing  
- Performance monitoring  
- Dependency mapping  

These can be added later without redesigning the workload architecture.

---

## 8. Governance and Compliance

The workload inherits governance from the landing zone, including:

- Required tagging  
- Allowed locations  
- Deny public IPs  
- Policy enforcement for secure configuration  
- Optional diagnostic settings  

Full governance details are documented in:  
`/docs/architecture/governance-and-policy.md`

---

## 9. Extensibility

The workload architecture is designed to scale as the environment grows.

Future enhancements may include:

- Additional workloads or microservices  
- API Management  
- Private endpoints for all platform services  
- Multi‑environment deployment (dev/test/prod)  
- CI/CD integration for application code  
- Application Insights and monitoring baselines  
- Integration with hybrid workloads via Arc  

The current implementation provides a secure, minimal foundation for cloud‑native application deployment.



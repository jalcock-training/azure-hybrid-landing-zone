# Shared Services

This document describes the shared platform services deployed in the Azure Hybrid Landing Zone.  
These services provide centralised security, monitoring, diagnostics, and secret management for both Azure‑native and Azure Arc–enabled resources.

For related documentation, see:
- `/docs/architecture/hub-and-spoke-network.md`
- `/docs/security/security-overview.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Purpose of Shared Services

Shared services provide the foundational capabilities required across the environment, including:

- Secure secret management  
- Centralised logging and diagnostics  
- Network visibility  
- Platform‑level storage  
- Administrative access support  

These services are deployed in the **hub network**, ensuring they are isolated from workloads while remaining accessible to authorised users and automation.

---

## 2. Key Vault

Azure Key Vault is deployed as the central secret store for the environment.

### Current configuration

- **Private endpoint enabled**  
- **Private DNS zone linked** for private name resolution  
- **Public network access disabled**  
- **Soft delete and purge protection enabled**  
- **RBAC‑based access control**  
- **Managed identities supported** for workloads and automation  

Key Vault is used for:

- Application secrets  
- Platform secrets  
- Terraform automation secrets (when required)  
- Certificates (future enhancement)

---

## 3. Storage Accounts

Storage accounts are deployed for platform and workload use.

### Current configuration

- **Private endpoints enabled** where required  
- **Private DNS zone linked**  
- **TLS enforced**  
- **Public network access disabled**  
- **Identity‑based access supported**  
- **Standard redundancy** to minimise cost  

Storage accounts support:

- Application data  
- Diagnostic logs (when enabled)  
- Platform artefacts  
- Future workload expansion

---

## 4. Log Analytics (Optional)

A Log Analytics workspace is available but **not required** for the minimal deployment.

### When deployed, it supports:

- Diagnostic settings from supported Azure resources  
- NSG flow logs (v2)  
- Azure Arc monitoring  
- Activity Log export (optional)  

Log Analytics is intentionally optional to support low‑cost operation.

---

## 5. Diagnostic Settings (Optional)

Diagnostic settings can be applied to supported resources when Log Analytics is enabled.

### Supported diagnostic sources include:

- Key Vault  
- Storage  
- Virtual networks  
- Subnets  
- NSGs  
- App Service (when deployed)  
- Azure Arc–enabled servers  

Diagnostic settings provide visibility into:

- Resource operations  
- Security events  
- Network traffic  
- Policy compliance  

Diagnostics are optional in this phase.

---

## 6. Activity Log Export

Subscription‑level Activity Log export is implemented to provide:

- Audit visibility  
- Administrative action tracking  
- Security‑relevant event history  

Activity logs can be sent to:

- Log Analytics (when deployed)  
- Storage (future enhancement)  
- Event Hub (future enhancement)

---

## 7. NSG Flow Logs (Optional)

NSG flow logs (v2) can be enabled for selected NSGs.

### When enabled, they provide:

- Network traffic visibility  
- Security analysis  
- Troubleshooting support  

Flow logs require:

- A storage account  
- (Optional) Log Analytics for analytics and queries  

---

## 8. Administrative Access Support

Shared services include components that support secure administrative access:

### Jump‑ACI
- Ephemeral container for identity‑based ingress  
- No public inbound ports  
- Outbound‑only connectivity  

### Jumphost VM
- Required for interactive administration  
- Located in the hub network  
- Accessed from Jump‑ACI  
- Currently uses a generic account with shared keys  
- Roadmap: named accounts with MFA  

These components ensure that administrative access is controlled, auditable, and isolated.

---

## 9. Extensibility

The shared services layer is designed to expand as the environment grows.

Future enhancements may include:

- Azure Automation Account  
- Azure Sentinel / SIEM integration  
- Defender for Cloud  
- Additional private endpoints  
- Private DNS resolver  
- Centralised logging via Event Hub  
- Certificate management in Key Vault  
- Backup and recovery services  
- Application Insights for workloads  

The current implementation provides a secure, minimal foundation suitable for hybrid and cloud‑native workloads.



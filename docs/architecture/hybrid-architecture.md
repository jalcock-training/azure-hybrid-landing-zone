# Hybrid Architecture (Azure Arc)

This document describes the hybrid architecture used in the Azure Hybrid Landing Zone, focusing on Azure Arc–enabled servers and how they integrate into the cloud governance, security, and operational model.

For related documentation, see:
- `/docs/architecture/hub-and-spoke-network.md`
- `/docs/security/security-overview.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Purpose of the Hybrid Architecture

The hybrid architecture demonstrates how on‑premises or edge servers can participate fully in Azure’s governance and security model using Azure Arc.

Key objectives include:

- Extending Azure governance to non‑Azure servers  
- Applying consistent tagging, naming, and policy enforcement  
- Demonstrating secure administrative access patterns  
- Providing visibility into hybrid resources  
- Supporting future enhancements such as monitoring and compliance baselines  

The design is intentionally minimal to keep cost and complexity low while still reflecting enterprise‑aligned hybrid patterns.

---

## 2. Azure Arc Integration

Azure Arc is used to onboard a Linux VM running outside Azure.  
Once onboarded, the VM becomes an Azure Resource Manager (ARM) resource and participates in the landing zone’s governance model.

### Current capabilities

- Azure Arc Connected Machine resource  
- Tagging and naming applied consistently  
- Subscription‑level policy assignments  
- Optional diagnostic settings  
- Visibility in Azure Resource Graph  
- Identity‑based access through the landing zone’s administrative access model  

### Not yet implemented (future enhancements)

- Guest configuration policies  
- Defender for Cloud integration  
- Extension‑based monitoring  
- Custom script extensions  
- Regulatory compliance initiatives  

These capabilities can be added later without redesigning the hybrid architecture.

---

## 3. Administrative Access Flow

Hybrid VM access follows the same secure, identity‑centric pattern as Azure‑native resources.

### Access chain

1. **Operator authentication**  
   - Performed using Azure CLI with OIDC‑based or identity‑based credentials  
   - MFA enforced at the identity provider level

2. **Jump‑ACI (ephemeral container)**  
   - Started on demand  
   - No inbound public ports  
   - Outbound‑only connectivity  
   - Provides a short‑lived, identity‑based entry point into the hub network

3. **Jumphost VM**  
   - Required for interactive administration  
   - Located in the hub network  
   - Receives connections only from Jump‑ACI  
   - Currently accessed using a generic account with shared keys  
   - Roadmap: named accounts with MFA

4. **Hybrid VM (Arc‑enabled)**  
   - Accessed from the jumphost VM  
   - No public IP  
   - No inbound internet exposure  
   - Governed by Azure Policy  

This model ensures that hybrid resources follow the same secure access patterns as Azure‑native workloads.

---

## 4. Governance for Hybrid Resources

Azure Arc–enabled servers participate fully in the landing zone’s governance model.

### Current governance includes:

- Required tagging  
- Allowed locations  
- Deny public IPs  
- Basic Arc baseline policies  
- Optional diagnostic forwarding to Log Analytics  

### Future governance enhancements:

- Guest configuration baselines  
- Defender for Cloud integration  
- Just‑in‑time access controls  
- Regulatory compliance initiatives  
- Policy initiatives for hybrid environments  

These enhancements can be layered on without changing the underlying architecture.

---

## 5. Monitoring and Diagnostics

Monitoring for hybrid resources is optional in this phase.

### When enabled:

- Diagnostic settings forward logs to Log Analytics  
- Arc metadata becomes queryable in Azure Resource Graph  
- NSG flow logs provide visibility into network traffic (if enabled)  

### Not yet implemented:

- Azure Monitor Agent (AMA)  
- Performance counters  
- Syslog collection  
- Dependency mapping  

These can be added later as part of the monitoring roadmap.

---

## 6. Network Integration

Hybrid resources do not require inbound connectivity from Azure.

### Current network model:

- Hybrid VM has **no public IP**  
- No inbound ports exposed  
- All access flows through the jumphost VM  
- Arc agent communicates outbound to Azure over HTTPS  
- No VPN or ExpressRoute required  

### Future enhancements:

- VPN or ExpressRoute connectivity  
- Private Link for Arc agent traffic (when supported)  
- Hybrid DNS integration  

The current model keeps the hybrid footprint minimal while maintaining secure connectivity.

---

## 7. Extensibility

The hybrid architecture is designed to scale as the environment grows.

Future enhancements may include:

- Additional Arc‑enabled servers  
- Windows Server onboarding  
- Kubernetes (AKS‑Arc) integration  
- Hybrid monitoring baselines  
- Defender for Cloud for hybrid workloads  
- Automated configuration using guest configuration  
- Multi‑site hybrid deployments  

The current implementation provides a clean, minimal foundation for hybrid governance and secure access.


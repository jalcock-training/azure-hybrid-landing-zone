# Security Overview

This document describes the security posture of the Azure Hybrid Landing Zone.  
The design follows secure‑by‑default principles and applies consistent controls across Azure‑native and Azure Arc–enabled resources.

For related documentation, see:
- `/docs/architecture/hub-and-spoke-network.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/architecture/shared-services.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Security Principles

The environment is built around the following principles:

- **Identity-first access**  
  All administrative access begins with Microsoft Entra ID authentication.

- **Least privilege**  
  RBAC assignments are scoped to the minimum required level.

- **No direct public exposure**  
  No compute resources in the hub or spoke VNets are reachable from the public internet.

- **Private connectivity for platform services**  
  Key Vault and Storage use private endpoints and private DNS zones.

- **Segmentation and isolation**  
  Hub and spoke VNets are isolated except for explicitly allowed flows.

- **Secure-by-default configuration**  
  NSGs, diagnostics, TLS enforcement, and identity-based access are applied wherever possible.

---

## 2. Identity and Access Control

Identity is centralised through Microsoft Entra ID.

### Administrative Access Flow

Administrative access follows a controlled, identity‑centric chain:

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
   - Receives connections only from Jump‑ACI  
   - Currently accessed using a generic account with shared keys  
   - Roadmap: named user accounts integrated with identity and MFA

4. **Hub and Spoke Resources**  
   - Access controlled by NSGs and private connectivity  
   - No direct inbound access from the internet

This model ensures that all administrative access is authenticated, controlled, and traceable.

---

## 3. Network Security

Network security is enforced through multiple layers:

- **No public IPs** on compute resources  
- **NSGs** with deny‑all inbound rules and minimal outbound allowances  
- **Hub-and-spoke segmentation** to isolate workloads  
- **Private endpoints** for Key Vault and Storage  
- **Private DNS zones** for private endpoint name resolution  
- **Controlled administrative ingress** via Jump‑ACI and the jumphost VM  

There is no Azure Firewall, Bastion, or VPN gateway in this phase.  
These can be added in future iterations.

---

## 4. Platform Service Security

Platform services are deployed with secure defaults:

### Key Vault
- Private endpoint enabled  
- Private DNS zone linked  
- Purge protection enabled  
- Soft delete enabled  
- Public network access disabled  
- Access controlled via RBAC and managed identities

### Storage
- Private endpoint enabled where required  
- Private DNS zone linked  
- TLS enforced  
- Public network access disabled  
- Identity-based access supported

### App Service (when deployed)
- Supports private endpoint integration  
- Public access can be disabled  
- Managed identity used for platform access

---

## 5. Hybrid Resource Security (Azure Arc)

Azure Arc–enabled servers participate fully in the landing zone’s security model:

- Governed by Azure Policy  
- Tagged and named consistently  
- Visible in Azure Resource Manager  
- Optional diagnostic forwarding to Log Analytics  
- No inbound public access to the on‑premises host  

Future enhancements may include:

- Guest configuration policies  
- Defender for Cloud integration  
- Advanced monitoring baselines

---

## 6. Monitoring and Logging

Monitoring is available and can be enabled as needed:

- **Log Analytics workspace** (optional)  
- **Diagnostic settings** for supported resources  
- **NSG flow logs (v2)** for selected NSGs  
- **Activity Log export** for subscription‑level events  

These features provide visibility into:

- Administrative actions  
- Network traffic  
- Policy compliance  
- Resource health  

Monitoring is optional in this phase to support low‑cost operation.

---

## 7. Governance and Compliance

Security is reinforced through subscription‑level governance:

- Required tagging  
- Allowed locations  
- Baseline security policies  
- Prevention of public IP assignment  
- Policy enforcement for Arc‑enabled servers  

Full governance details are documented in:  
`/docs/architecture/governance-and-policy.md`

---

## 8. Extensibility

The security architecture is designed to evolve.  
Future enhancements may include:

- Azure Firewall or third‑party NVAs  
- Bastion for browser‑based VM access  
- VPN or ExpressRoute connectivity  
- Defender for Cloud integration  
- Management‑group–level governance  
- Named accounts with MFA on the jumphost VM  
- Additional private endpoints and private DNS zones  
- Multi‑region or zone‑redundant security patterns  

The current implementation provides a strong, secure foundation while remaining cost‑efficient and easy to extend.



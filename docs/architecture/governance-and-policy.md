# Governance and Policy

This document describes the governance and policy model used in the Azure Hybrid Landing Zone.  
The design applies consistent, secure, and enforceable standards across Azure‑native and Azure Arc–enabled resources while remaining minimal and cost‑efficient.

For related documentation, see:
- `/docs/security/security-overview.md`
- `/docs/architecture/landing-zone-design.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Governance Objectives

The governance model ensures that all resources—cloud or hybrid—are deployed within a controlled, compliant, and secure framework.

Key objectives include:

- Enforcing consistent tagging and naming  
- Applying secure‑by‑default configuration baselines  
- Restricting resource deployment to approved regions  
- Preventing insecure configurations (e.g., public IPs)  
- Governing Azure Arc–enabled servers  
- Providing visibility through optional diagnostics and logging  

The model is intentionally minimal to support low‑cost operation while demonstrating enterprise‑aligned governance patterns.

---

## 2. Governance Scope

Governance is applied at the **subscription level** in this phase of the project.

This includes:

- Subscription‑level Azure Policy assignments  
- RBAC assignments at subscription and resource‑group scopes  
- Required tagging  
- Location restrictions  
- Arc baseline policies  
- Optional diagnostic settings  

A full management‑group hierarchy and multi‑subscription model are planned for future enhancements.

---

## 3. Identity and Access Governance

Identity is centralised through Microsoft Entra ID.  
Governance ensures:

- RBAC follows least‑privilege principles  
- No long‑lived credentials or local admin accounts  
- Automation uses OIDC‑based authentication  
- Administrative access flows through:

  1. Azure CLI authentication  
  2. Jump‑ACI (ephemeral, identity‑based)  
  3. Jumphost VM (generic account today; named accounts with MFA planned)  

Identity governance is enforced consistently across Azure‑native and Arc‑enabled resources.

---

## 4. Tagging Governance

Tagging is enforced through Azure Policy to support:

- Cost management  
- Ownership clarity  
- Resource classification  
- Operational consistency  

Required tags include:

- `Environment`  
- `Owner`  
- `Project`  
- `Application`  
- `CostCentre` (optional in this phase)

Tagging standards are defined in:  
`/docs/reference/naming-and-tagging-standards.md`

---

## 5. Naming Governance

Naming consistency is enforced through:

- Terraform variables  
- Module‑level naming patterns  
- Policy‑driven validation where applicable  

Naming standards are defined in:  
`/docs/reference/naming-and-tagging-standards.md`

---

## 6. Policy Assignments

The landing zone applies a set of subscription‑level policies that enforce secure and consistent configuration.

### **Current policy assignments**

- **Required tags**  
  Ensures all resources include the standard tag set.

- **Allowed locations**  
  Restricts deployments to the intended Azure region.

- **Deny public IPs on compute resources**  
  Prevents accidental exposure of VMs and Arc servers.

- **Azure Arc baseline policies**  
  Ensures Arc‑enabled servers meet minimum governance requirements.

- **Optional diagnostic settings**  
  Enables diagnostic forwarding when Log Analytics is deployed.

### **Not yet implemented (future enhancements)**

- Policy initiatives (bundled policies)  
- Defender for Cloud regulatory compliance  
- Guest configuration baselines for Arc servers  
- Policy‑driven private endpoint enforcement  
- Management‑group–level governance  

These will be introduced in later phases.

---

## 7. Azure Arc Governance

Azure Arc–enabled servers participate fully in the governance model.

Current governance includes:

- Required tagging  
- Allowed locations  
- Deny public IPs  
- Basic Arc baseline policies  
- Optional diagnostic forwarding to Log Analytics  

Future enhancements may include:

- Guest configuration policies  
- Defender for Cloud integration  
- Advanced monitoring baselines  
- Just‑in‑time access controls  

---

## 8. Logging and Audit Governance

Logging and audit controls include:

- **Activity Log export** (subscription‑level)  
- **NSG flow logs (v2)** when enabled  
- **Diagnostic settings** for supported resources  
- **Optional Log Analytics workspace** for centralised monitoring  

These controls provide visibility into:

- Administrative actions  
- Network traffic  
- Policy compliance  
- Resource health  

Logging is optional in this phase to support low‑cost operation.

---

## 9. Extensibility

The governance model is designed to scale.  
Future enhancements may include:

- Full management‑group hierarchy  
- Multi‑subscription landing zone  
- Policy initiatives for security and compliance  
- Defender for Cloud integration  
- Private endpoint enforcement policies  
- Advanced Arc governance  
- Regulatory compliance mappings  
- Automated remediation  

The current implementation provides a strong, minimal foundation for enterprise‑aligned governance.



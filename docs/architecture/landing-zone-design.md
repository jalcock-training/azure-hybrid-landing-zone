# Landing Zone Design

This document describes the design of the Azure Landing Zone that underpins the hybrid cloud environment.  
The landing zone establishes the governance, identity, policy, and subscription structure required to support secure, consistent, and scalable deployments across both Azure‑native and Azure Arc–enabled resources.

For related documentation, see:
- `/docs/architecture/governance-and-policy.md`
- `/docs/security/security-overview.md`
- `/docs/reference/naming-and-tagging-standards.md`
- `/docs/reference/terraform-structure.md`

---

## 1. Purpose of the Landing Zone

The landing zone provides the foundational control plane for the environment.  
Its purpose is to ensure that all resources—cloud or hybrid—are deployed within a governed, compliant, and secure framework.

Key objectives include:

- Consistent identity and access management  
- Centralised policy enforcement  
- Standardised tagging and naming  
- Clear separation of platform and workload responsibilities  
- A structure that can scale in future phases  

The landing zone is intentionally minimal to maintain cost‑efficiency while still demonstrating enterprise‑aligned patterns.

---

## 2. Governance Scope

In this phase, governance is applied at the **subscription level**.  
This avoids tenant‑root permissions while remaining aligned with Azure landing zone principles.

Key elements include:

- Subscription‑level Azure Policy assignments  
- RBAC applied at subscription and resource‑group scopes  
- Required tagging and naming standards  
- Policy enforcement for secure configuration baselines  
- A single subscription hosting platform, workload, and hybrid resources  

A full management‑group hierarchy and multi‑subscription model are planned for future enhancements.

---

## 3. Identity and Access Management

Identity is centralised through Microsoft Entra ID.  
The landing zone enforces identity‑first access using:

- Role‑based access control (RBAC) at subscription and resource‑group scopes  
- Least‑privilege assignments for administrators and automation identities  
- Managed identities or OIDC‑based authentication for Terraform and GitHub Actions  
- MFA for all administrative access  
- No unmanaged local accounts or long‑lived credentials  

These controls ensure consistent access governance across cloud and hybrid assets.

---

## 4. Policy and Governance

Azure Policy enforces baseline governance across the environment.  
Initial policy assignments include:

- Required tagging for cost management and classification  
- Allowed locations to prevent accidental deployment outside the intended region  
- Baseline security configurations for Azure Arc–enabled servers  
- Optional diagnostic settings for supported resources  
- Prevention of public IP assignment to compute resources  
- Enforcement of secure defaults for platform services  

Policies are applied at the subscription scope in this phase.  
Future versions may move these to the management‑group level.

For full governance details, see:  
`/docs/architecture/governance-and-policy.md`.

---

## 5. Subscription Design

The environment uses a **single‑subscription model** for this phase of the project.

This subscription hosts:

- The hub network and shared services  
- The spoke network and application workloads  
- Azure Arc–enabled hybrid resources  
- All platform and workload resources deployed with secure defaults  

This structure supports free‑tier compatibility while still reflecting common enterprise patterns.

A multi‑subscription model will be introduced in a future iteration.

---

## 6. Naming and Tagging Standards

The landing zone applies consistent naming and tagging across all resources.  
These standards support governance, cost management, and operational clarity.

Naming and tagging conventions are defined in:  
`/docs/reference/naming-and-tagging-standards.md`

---

## 7. Region and Availability Considerations

The environment is deployed in a **single Azure region** to minimise cost and complexity.  
High availability, zone redundancy, and multi‑region patterns are intentionally out of scope for this phase but can be added later.

---

## 8. Integration with Hybrid Resources

Azure Arc–enabled servers participate fully in the landing zone governance model.  
This includes:

- Policy‑driven configuration  
- RBAC through Azure Resource Manager  
- Optional diagnostic forwarding to Log Analytics  
- Consistent tagging and naming  

Hybrid resources follow the same operational and governance standards as Azure‑native resources.

---

## 9. Extensibility

The landing zone is designed to be minimal yet extensible.  
Future enhancements may include:

- Full management‑group hierarchy  
- Multi‑subscription architecture  
- Private DNS zones and centralised name resolution  
- Defender for Cloud integration  
- Additional spokes and workload environments  
- Advanced policy initiatives and security baselines  

The current design provides a solid foundation for these future capabilities.


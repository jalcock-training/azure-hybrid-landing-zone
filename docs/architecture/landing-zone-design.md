# Landing Zone Design

This document describes the design of the Azure Landing Zone that underpins the hybrid cloud environment. The landing zone establishes the governance, identity, policy, and subscription structure required to support secure, scalable, and consistent deployments across both Azure-native and Azure Arc–enabled resources.

## 1. Purpose of the Landing Zone

The landing zone provides the foundational control plane for the environment. Its purpose is to ensure that all resources—cloud or hybrid—are deployed within a governed, compliant, and well‑structured framework. This includes:

- Consistent identity and access management
- Centralised policy enforcement
- Standardised naming and tagging
- Clear separation of platform and workload responsibilities within a single subscription
- A structure that can scale to multiple environments or teams in future phases

The landing zone is intentionally minimal for this project, focusing on subscription‑scoped governance to maintain free‑tier compatibility while still demonstrating enterprise‑aligned patterns.

## 2. Governance Scope

In this phase, governance is applied at the subscription level rather than through a full management‑group hierarchy. This maintains alignment with Azure landing zone principles while avoiding features that require tenant‑root permissions.

Key elements include:
- Subscription‑level Azure Policy assignments
- RBAC applied at subscription and resource‑group scopes
- Naming and tagging standards
- A single subscription hosting both platform and workload resources

A full management‑group hierarchy and subscription vending model will be introduced in a future enterprise‑grade version of the landing zone.

## 3. Identity and Access Management

Identity is centralised through Microsoft Entra ID. Key design elements include:

- Role‑based access control (RBAC) applied at management group and subscription levels
- Least‑privilege assignments for administrators and automation identities
- Use of managed identities or service principals for Terraform and GitHub Actions
- No local accounts or unmanaged credentials on Azure resources

This ensures consistent access control across cloud and hybrid assets.

## 4. Policy and Governance

Azure Policy is used to enforce baseline governance across the environment. Initial policy assignments include:

- Required tagging for cost management and resource classification
- Allowed locations to prevent accidental deployment outside the intended region
- Baseline security configurations for Azure Arc–enabled servers
- Optional diagnostic settings for supported resources

Policies are applied at the subscription scope in this phase.
In a future version, these policies will be moved to the management‑group level to support multi‑subscription governance.

## 5. Subscription Design

The environment uses a single‑subscription model for this phase of the project.

This subscription hosts:
- The hub network and shared services
- The spoke network and application workloads
- Azure Arc–enabled hybrid resources

This simplified structure supports free‑tier compatibility while still reflecting common enterprise patterns.
A multi‑subscription model will be introduced in a future iteration.

## 6. Naming and Tagging Standards

A consistent naming and tagging strategy is applied across all resources. The goals are clarity, traceability, and alignment with enterprise conventions. Standards include:

- Resource names that reflect purpose, region, and environment
- Mandatory tags for:
  - Environment
  - Owner
  - Cost centre or project
  - Application or service name

These standards support governance, cost management, and operational clarity.

## 7. Region and Availability Considerations

The environment is deployed in a single Azure region to minimise cost and complexity. High availability and multi‑region patterns are intentionally out of scope for this project but can be added later as enhancements.

## 8. Integration with Hybrid Resources

Azure Arc–enabled servers are governed through the same landing zone structure as native Azure resources. This includes:

- Policy assignments for configuration and monitoring
- RBAC applied through Azure Resource Manager
- Optional diagnostic forwarding to the shared Log Analytics workspace

This ensures hybrid resources participate fully in the governance model.

## 9. Extensibility

The landing zone is designed to be minimal yet extensible. Future enhancements may include:

- Full management‑group hierarchy for environment separation (e.g., dev/test/prod)
- Subscription vending and multi‑subscription architecture
- Additional management groups for environment separation (e.g., dev/test/prod)
- More advanced policy initiatives
- Integration with Defender for Cloud
- Private DNS zones and centralised name resolution
- Additional workload subscriptions

The current design provides a solid foundation for these future capabilities.

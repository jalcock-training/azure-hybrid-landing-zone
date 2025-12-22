# Landing Zone Design

This document describes the design of the Azure Landing Zone that underpins the hybrid cloud environment. The landing zone establishes the governance, identity, policy, and subscription structure required to support secure, scalable, and consistent deployments across both Azure-native and Azure Arc–enabled resources.

## 1. Purpose of the Landing Zone

The landing zone provides the foundational control plane for the environment. Its purpose is to ensure that all resources—cloud or hybrid—are deployed within a governed, compliant, and well‑structured framework. This includes:

- Consistent identity and access management
- Centralised policy enforcement
- Standardised naming and tagging
- Separation of platform and workload responsibilities
- A structure that can scale to multiple environments or teams

The landing zone is intentionally minimal for this project, focusing on the core elements required to demonstrate enterprise‑grade governance without incurring unnecessary cost.

## 2. Management Group Hierarchy

A lightweight management group hierarchy is used to organise governance boundaries:

- **Root Management Group**  
  The top‑level container for all governance assignments.

- **Platform Management Group**  
  Contains the subscription hosting shared services and the hub network.

- **Landing Zones Management Group**  
  Contains workload subscriptions, including the spoke network and application resources.

This structure allows policies and RBAC to be applied at the appropriate scope while keeping the environment simple and cost‑efficient.

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
- Enforced diagnostic settings for supported resources
- Allowed locations to prevent accidental deployment outside the intended region
- Baseline security configurations for Azure Arc–enabled servers

Policies are applied at the management group level to ensure consistent governance across all subscriptions.

## 5. Subscription Design

The environment uses a two‑subscription model:

- **Platform Subscription**  
  Hosts the hub network, shared services (Log Analytics, Key Vault), and any future platform components.

- **Landing Zone Subscription**  
  Hosts the spoke network and application workloads.

This separation reflects common enterprise patterns and supports clear boundaries between platform and workload responsibilities.

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

- Additional management groups for environment separation (e.g., dev/test/prod)
- More advanced policy initiatives
- Integration with Defender for Cloud
- Private DNS zones and centralised name resolution
- Additional workload subscriptions

The current design provides a solid foundation for these future capabilities.

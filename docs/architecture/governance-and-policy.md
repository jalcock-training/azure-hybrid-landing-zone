# Governance and Policy Architecture

This document describes the governance and policy model used in the Azure Hybrid Landing Zone project. Governance ensures that all resources—cloud and hybrid—are deployed, configured, and operated in a consistent, secure, and compliant manner. The design follows Azure landing zone principles while remaining minimal and cost‑efficient.

## 1. Purpose of Governance

The governance model provides a structured framework for managing the environment. Its goals are to:

- Enforce consistent configuration across all resources
- Apply security and compliance controls
- Standardise naming, tagging, and resource organisation
- Ensure visibility through monitoring and diagnostics
- Govern both Azure‑native and Azure Arc–enabled resources
- Support scalable, multi‑environment growth

Governance is applied through management groups, Azure Policy, RBAC, and standardised resource organisation.

## 2. Management Group Hierarchy

A lightweight management group hierarchy provides the foundation for governance:

- **Root Management Group**  
  The top‑level scope for global governance assignments.

- **Platform Management Group**  
  Contains the subscription hosting shared services and the hub network.

- **Landing Zones Management Group**  
  Contains workload subscriptions, including the spoke network and application resources.

This structure allows governance to be applied at the appropriate scope while keeping the environment simple.

## 3. Role‑Based Access Control (RBAC)

Identity and access management is centralised through Microsoft Entra ID. RBAC is applied using least‑privilege principles:

- Platform administrators manage shared services and networking
- Workload administrators manage application resources
- Automation identities use scoped permissions for Terraform and CI/CD
- No unmanaged local accounts or long‑lived credentials

RBAC assignments are made at the management group or subscription level to ensure consistency.

## 4. Azure Policy

Azure Policy enforces configuration standards across the environment. The initial policy set includes:

### Tagging Policies

- Required tags for:
  - Environment
  - Owner
  - Cost centre or project
  - Application or service name

These support cost management, classification, and operational clarity.

### Location Policies

- Allowed locations to prevent accidental deployment outside the intended region

This ensures resources remain within governance boundaries.

### Diagnostic Policies

- Enforce diagnostic settings for supported resources
- Forward logs and metrics to the shared Log Analytics workspace

This ensures consistent monitoring across cloud and hybrid assets.

### Security Baseline Policies

- Baseline security configurations for Azure Arc–enabled servers
- Optional guest configuration policies for hybrid resources

These policies ensure hybrid assets follow the same governance standards as Azure‑native resources.

## 5. Governance for Hybrid Resources

Azure Arc enables hybrid resources to participate fully in the governance model. This includes:

- Policy assignments applied at the management group or subscription level
- Required tagging for classification
- Optional monitoring through Log Analytics
- RBAC applied through Azure Resource Manager

Hybrid resources follow the same governance patterns as cloud resources without requiring network connectivity to Azure VNets.

## 6. Resource Organisation

Resources are organised using a consistent structure:

- **Management groups** for governance boundaries
- **Subscriptions** for platform and workload separation
- **Resource groups** for logical grouping of related resources
- **Naming standards** for clarity and traceability
- **Tagging standards** for classification and cost management

This structure supports operational clarity and scalability.

## 7. Compliance and Visibility

Governance ensures visibility across the environment through:

- Centralised monitoring in Log Analytics
- Policy compliance reporting
- RBAC audit logs
- Terraform‑driven drift detection

These capabilities support operational oversight and troubleshooting.

## 8. Extensibility

The governance model is designed to scale as the environment grows. Future enhancements may include:

- Additional policy initiatives for security or compliance
- Defender for Cloud integration
- More granular RBAC roles
- Multi‑environment management group structure (dev/test/prod)
- Private DNS zones and centralised name resolution
- Policy‑driven configuration for Arc‑enabled Kubernetes or SQL Server

The current implementation provides a minimal but realistic governance foundation.



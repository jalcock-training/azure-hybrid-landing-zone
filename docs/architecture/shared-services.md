# Shared Services

This document describes the shared services that support the Azure Hybrid Landing Zone project. These services are deployed in the hub resource group within a single subscription and provide centralised capabilities used by both cloud and hybrid resources. The design focuses on essential services that enable governance, monitoring, and secure operations while keeping cost and complexity low.

## 1. Purpose of Shared Services

Shared services provide foundational capabilities that are consumed across the environment. Their goals include:

- Centralising monitoring and diagnostics
- Providing secure secret and key management
- Supporting governance and compliance
- Reducing duplication across workloads
- Enabling consistent operational practices

The shared services layer is intentionally minimal for this project but reflects common enterprise patterns.

## 2. Log Analytics Workspace

The Log Analytics workspace is an optional shared monitoring component for the environment. It receives logs and metrics from:

- Hub and spoke network resources
- Application services
- Optional Azure Arc–enabled servers
- Platform services such as Key Vault

### Key Characteristics

- Deployed once within the same subscription as hub and spoke resources (optional or future)
- Acts as the central monitoring point for the environment
- Supports Azure Monitor, alerts, and policy compliance
- Configured with minimal retention to control cost

The workspace enables unified visibility across cloud and hybrid assets when enabled.

## 3. Azure Key Vault

Azure Key Vault provides secure storage for secrets, certificates, and keys used by the environment.

### Key Characteristics

- Standard tier to minimise cost
- Used for storing automation credentials where required
- Supports integration with Terraform and GitHub Actions
- Can be extended to support application secrets in future enhancements

Key Vault ensures that sensitive information is managed securely and consistently.

## 4. Diagnostic Settings

Diagnostic settings are configured to forward logs and metrics from supported resources to the Log Analytics workspace. This is optional in the current phase and enabled only when a workspace is deployed. 
This includes:

- Virtual networks
- Subnets (where applicable)
- Application services
- Storage accounts
- Key Vault

This ensures consistent monitoring and supports governance, troubleshooting, and compliance.

## 5. Optional Shared Services

The architecture allows for additional shared services to be added as the environment grows. These may include:

- Azure Bastion for secure remote access
- Azure Automation Account for runbooks and update management
- Private DNS zones for centralised name resolution
- Azure Firewall or third‑party network virtual appliances
- Defender for Cloud for security posture management

These services are not deployed in the initial implementation to keep the environment lightweight and cost‑efficient.

## 6. Integration with Hybrid Resources

Hybrid resources onboarded through Azure Arc can consume shared services in the same way as cloud resources. This includes:

- Forwarding logs to the Log Analytics workspace
- Using Key Vault for secret retrieval (if configured)
- Participating in policy‑driven monitoring and compliance

This ensures hybrid assets follow the same operational model as Azure‑native resources.

## 7. Extensibility

The shared services layer is designed to scale as the project evolves. Future enhancements may include:

- Multiple Log Analytics workspaces for environment separation
- Centralised alerting and incident response workflows
- Integration with SIEM or SOC tooling
- Additional automation and configuration management services

The current implementation provides a minimal but realistic foundation for enterprise shared services.

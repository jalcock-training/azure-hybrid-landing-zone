# Hybrid Architecture (Azure Arc)

This document describes the hybrid architecture used in the Azure Hybrid Landing Zone project. The hybrid component demonstrates how Azure can extend governance, monitoring, and configuration management to on‑premises resources using Azure Arc. The design focuses on simplicity and cost‑efficiency while reflecting real‑world enterprise patterns.

## 1. Purpose of the Hybrid Architecture

The hybrid architecture enables Azure to manage resources that run outside the cloud. This project uses a small on‑premises Linux virtual machine to demonstrate:

- Centralised governance through Azure Policy
- Inventory and metadata visibility in Azure Resource Manager
- Optional monitoring through a Log Analytics workspace (if deployed)
- Consistent automation and configuration management
- A unified operational model for cloud and on‑premises assets

The hybrid component is intentionally minimal but provides a foundation for more advanced scenarios.

## 2. On‑Premises Environment

The on‑premises environment consists of a lightweight virtual machine hosted on a local KVM hypervisor. This VM represents a typical server running in a data centre or edge location.

### Key Components

- KVM Hypervisor
  Provides the local virtualisation platform.

- Linux Virtual Machine
  Runs a supported distribution such as Ubuntu or Rocky Linux.

- NGINX Web Server
  Used as a simple workload to demonstrate configuration and management.

This environment is not connected to Azure via VPN or ExpressRoute; instead, it integrates through Azure Arc.

## 3. Azure Arc–Enabled Server

Azure Arc enables the on‑premises VM to appear in Azure as a first‑class resource. Once onboarded, it participates in the same governance and management model as native Azure resources.

### Capabilities Enabled

- Azure Resource Manager Integration
  The VM is represented as a Connected Machine resource.

- Policy and Governance
  Azure Policy can audit or enforce configurations on the VM.

- Access Control
  RBAC applies through Azure Resource Manager, not local accounts.

- Optional Monitoring
  The VM can forward logs and metrics to a Log Analytics workspace when one is deployed.

- Configuration Management
  GitHub Actions or other automation tools can apply updates or manage configuration.

Azure Arc provides a consistent operational model without requiring network‑level connectivity to Azure VNets.

## 4. Governance and Policy Integration

Hybrid resources are governed through the same landing zone structure as cloud resources. This includes:

- Policy assignments at the subscription level (subscription‑scoped governance)
- Required tagging for classification and cost management
- Baseline security and configuration policies
- Optional guest configuration policies

This ensures hybrid assets follow the same governance standards as Azure‑native workloads within the subscription‑scoped landing zone.

## 5. Monitoring and Diagnostics

Monitoring for the hybrid VM is optional and intentionally minimal to control cost. When enabled:

- Logs and metrics are forwarded to the shared Log Analytics workspace
- Diagnostic settings follow the same pattern as cloud resources
- Monitoring data supports inventory, compliance, and troubleshooting

The monitoring relationship is conceptual rather than network‑based and is not shown in the high‑level diagram to maintain clarity.

## 6. Automation and Configuration

Automation for the hybrid VM is delivered through the same CI/CD pipeline used for cloud resources. This includes:

- Terraform for onboarding and resource representation
- GitHub Actions for configuration updates or deployments
- OIDC‑based authentication for secure automation
- Consistent workflows across cloud and hybrid environments

This demonstrates how hybrid resources can be managed using modern DevOps practices.

## 7. Security Considerations

The hybrid architecture is designed with security in mind:

- No inbound ports are required from Azure to the on‑premises VM
- All communication is agent‑initiated and outbound
- RBAC and policy enforcement occur through Azure Resource Manager
- Secrets and credentials are managed through Azure Key Vault where applicable

This model reduces attack surface while maintaining strong governance.

## 8. Extensibility

The hybrid architecture can be expanded to support more advanced scenarios, including:

- Multiple Arc‑enabled servers
- Arc‑enabled Kubernetes clusters
- Arc‑enabled SQL Server or data services
- Configuration management at scale
- Integration with Defender for Cloud
- Edge or branch office deployments

The current implementation provides a minimal but realistic foundation for hybrid cloud operations.

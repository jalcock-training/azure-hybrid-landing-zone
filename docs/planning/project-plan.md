# Project Plan

This document outlines the project plan for the Azure Hybrid Landing Zone. It defines the phases, deliverables, and sequencing required to build a minimal, cost‑efficient, and enterprise‑aligned hybrid cloud environment using Azure, Azure Arc, Terraform, and GitHub Actions. The plan is structured to allow incremental progress while maintaining a clear architectural direction.

## 1. Project Objectives

The primary objectives of the project are to:

- Build a minimal but realistic Azure landing zone aligned with enterprise governance patterns
- Deploy a hub‑and‑spoke network topology with shared services
- Demonstrate hybrid cloud integration using Azure Arc
- Implement infrastructure‑as‑code using Terraform
- Establish a secure CI/CD pipeline using GitHub Actions and OIDC
- Produce clear, professional documentation suitable for portfolio presentation

The project emphasises clarity, governance, and automation over complexity.

## 2. Project Scope

The scope includes:

- Management group hierarchy and governance baseline
- Platform and workload subscriptions
- Hub and spoke virtual networks
- Shared services (Log Analytics, Key Vault)
- Application workload (App Service and Storage)
- Azure Arc onboarding for an on‑premises VM
- Terraform modules and root configuration
- GitHub Actions CI/CD pipeline
- Documentation and architectural diagrams

The following items are explicitly out of scope for the initial implementation:

- Multi‑region deployments
- Azure Firewall or advanced network appliances
- Private DNS zones
- ExpressRoute or VPN connectivity
- High‑availability or production‑grade workloads

These may be added as future enhancements.

## 3. Project Phases

The project is divided into sequential phases to support incremental delivery.

### Phase 1: Foundations and Governance

- Create management group hierarchy
- Configure baseline Azure Policy assignments
- Establish naming and tagging standards
- Create platform and workload subscriptions
- Document the landing zone design

### Phase 2: Hub Network and Shared Services

- Deploy hub virtual network and subnets
- Deploy Log Analytics workspace
- Deploy Azure Key Vault
- Configure diagnostic settings
- Document shared services and network design

### Phase 3: Spoke Network and Application Workload

- Deploy spoke virtual network and subnets
- Deploy App Service (Free tier)
- Deploy Storage account
- Configure VNet peering between hub and spoke
- Document the workload environment

### Phase 4: Hybrid Integration with Azure Arc

- Prepare on‑premises KVM VM
- Install Azure Arc agent and onboard VM
- Apply governance and optional monitoring policies
- Document the hybrid architecture

### Phase 5: Automation and CI/CD

- Create Terraform root module and supporting modules
- Configure GitHub Actions workflow
- Implement OIDC authentication to Azure
- Add validation, planning, and manual approval steps
- Document the automation pipeline

### Phase 6: Final Documentation and Presentation

- Finalise architectural diagrams
- Complete documentation set
- Review repository structure and polish public presentation
- Prepare summary for LinkedIn or portfolio use

## 4. Deliverables

Each phase produces clear deliverables:

- Management group and policy configuration
- Hub and spoke networks
- Shared services deployment
- Application workload deployment
- Azure Arc–enabled server
- Terraform modules and CI/CD pipeline
- Documentation set:
  - Architectural overview
  - Landing zone design
  - Hub and spoke network design
  - Hybrid architecture
  - Shared services
  - Automation and CI/CD
  - Project plan

These deliverables form a complete, professional portfolio project.

## 5. Tools and Technologies

The project uses the following tools:

- Azure Resource Manager
- Azure Policy
- Azure Arc
- Terraform
- GitHub Actions
- OpenID Connect (OIDC)
- Draw.io for diagrams
- Markdown for documentation

These tools reflect modern cloud engineering practices.

## 6. Risks and Constraints

The project is designed to minimise cost and complexity. Key constraints include:

- Use of free or low‑cost Azure services
- No advanced networking or security appliances
- Single‑region deployment
- Minimal monitoring ingestion to control Log Analytics cost

Risks include:

- Changes to Azure free tier limits
- Terraform provider updates
- GitHub Actions workflow changes

These risks are low and manageable.

## 7. Future Enhancements

The project is designed to be extensible. Potential enhancements include:

- Additional spokes for multi‑environment scenarios
- Azure Firewall or third‑party NVAs
- Private DNS zones and centralised name resolution
- Defender for Cloud integration
- Arc‑enabled Kubernetes or SQL Server
- Multi‑region or production‑grade deployments

These enhancements can be added incrementally without redesigning the core architecture.



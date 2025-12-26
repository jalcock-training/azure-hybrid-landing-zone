# Terraform Structure

This document describes the Terraform structure used in the Azure Hybrid Landing Zone project. The goal of the structure is to provide clarity, modularity, and scalability while keeping the implementation easy to understand and cost‑efficient. The layout follows common enterprise patterns and supports future expansion into multi‑environment or multi‑subscription deployments.

## 1. Design Principles

The Terraform structure is based on the following principles:

- Modularity
Each major architectural component is implemented as a separate module.

- Separation of concerns
Governance, networking, shared services, workloads, and hybrid resources are isolated into logical units.

- Reusability
Modules can be reused or extended as the environment grows.

- Clarity
The root module orchestrates the deployment and provides a single entry point.

- Scalability
The structure supports future multi‑environment or multi‑region expansion without redesign.

- Security-by-default 
Modules enforce secure configuration baselines through Azure Policy, private endpoints, and least‑privilege identity patterns.

## 2. Directory Layout

The Terraform codebase uses a standard layout with a root module and child modules:

terraform/
main.tf
variables.tf
outputs.tf
providers.tf

modules/
landing-zone/
hub-network/
spoke-network/
shared-services/
application-workload/
arc-onboarding/
security-baselines/ (future) 
private-dns/ (future)


### Root Module

The root module is responsible for:

- Calling child modules
- Passing shared variables
- Defining providers
- Managing remote state (if enabled)
- Orchestrating the overall deployment
- Enforcing consistent security defaults across all modules (tags, locations, private access, diagnostics)

This provides a single, consistent entry point for the CI/CD pipeline.

### Child Modules

Each module represents a logical architectural component:

- landing-zone
Management groups, policy assignments, RBAC, subscription structure.
Includes security baselines such as required tags, allowed locations, and diagnostic settings.

- hub-network
Hub VNet, subnets, peering configuration, shared network settings.
Enforces NSGs, deny‑all inbound rules, and private endpoints for shared services.

- spoke-network
Spoke VNet, subnets, workload network configuration.
Ensures workload isolation and prevents public IP assignment.

- shared-services
Log Analytics workspace, Key Vault, diagnostic settings.
Configures secure defaults such as Key Vault firewalls, purge protection, and TLS enforcement.

- application-workload
App Service, Storage account, workload‑specific resources.
Supports secure access patterns using managed identities and private endpoints.

- arc-onboarding
Azure Arc Connected Machine resource and related configuration.
Applies policy-driven configuration baselines to hybrid resources.

This structure mirrors the architecture documents and keeps the codebase intuitive.

## 3. Module Design

Each module follows a consistent pattern:

- `main.tf` — core resources
- `variables.tf` — input variables
- `outputs.tf` — exported values
- `README.md` — optional module‑level documentation
- Secure defaults embedded directly into modules (e.g., disable public access, enforce TLS, enable diagnostics)

This consistency improves readability and makes modules easier to maintain.

## 4. Providers and Authentication

The root module defines all providers, including:

- AzureRM provider
- AzureAD provider (if required)
- Random provider (optional)

Authentication is handled through:

- GitHub Actions using OIDC
- Local development using Azure CLI authentication
- No long‑lived credentials; all automation uses short‑lived identity tokens
- Provider configuration scoped to least‑privilege access for Terraform operations

This ensures secure, consistent authentication across environments.

## 5. State Management

The project initially uses local state for simplicity. The structure supports future migration to remote state using:

- Azure Storage Account
- State locking via Azure Blob leases
- Private endpoints and firewall rules recommended for securing remote state (future)

Remote state can be introduced without changing module structure.

## 6. Variable and Output Conventions

Variables follow a consistent naming pattern:

- `prefix` for naming conventions
- `location` for region
- `tags` for standard tagging
- Component‑specific variables for module configuration
- Security-related variables (e.g., enable_private_endpoints, enable_diagnostics) default to secure values

Outputs expose only what is required by other modules or the root module.

This keeps modules loosely coupled and easy to reuse.

## 7. CI/CD Integration

The GitHub Actions pipeline interacts only with the root module. It performs:

- Formatting and validation
- Planning
- Manual approval
- Apply
- Security-sensitive changes (network, identity, policy) receive explicit review during approval

The pipeline does not call modules directly; all orchestration flows through the root module.

This ensures predictable, controlled deployments.

## 8. Extensibility

The Terraform structure is designed to scale as the environment grows. Future enhancements may include:

- Additional modules for new spokes or workloads
- Modules for private DNS zones or advanced networking
- Modules for Defender for Cloud or security baselines
- Environment‑specific root modules (dev/test/prod)
- Modules for enforcing Microsoft Cloud Security Benchmark (MCSB) controls 
- Modules for private DNS and secure name resolution 
- Additional policy-as-code modules for enterprise governance

The current structure provides a clean, minimal foundation that supports these future capabilities.

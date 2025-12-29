# Terraform Structure

This document describes the Terraform structure used in the Azure Hybrid Landing Zone project.  
The structure reflects the current implementation and is designed to be modular, secure‑by‑default, and easy to extend as the environment grows.

For related documentation, see:
- `/docs/security/security-overview.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/architecture/automation-and-ci-cd.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Design Principles

The Terraform structure is built around the following principles:

- **Modularity** — each architectural component is implemented as a separate module  
- **Separation of concerns** — governance, networking, shared services, workloads, and hybrid resources are isolated  
- **Reusability** — modules can be reused or extended  
- **Clarity** — the root module provides a single orchestration entry point  
- **Scalability** — supports future multi‑environment or multi‑subscription expansion  
- **Secure‑by‑default** — modules embed secure configuration baselines (no public IPs, TLS enforcement, diagnostics, private access)

---

## 2. Directory Layout

The Terraform codebase consists of a root module and a set of reusable child modules.

### Root Terraform Configuration

Located in the `terraform/` directory:

terraform/
  main.tf
  variables.tf
  outputs.tf
  providers.tf
  terraform.tfvars
  locals.tf
  *.tf (component orchestration files)


The root module:

- orchestrates all child modules  
- defines shared variables, providers, and outputs  
- is the **only** entry point used by CI/CD  

### Modules Directory

Reusable modules are stored under `terraform/modules/`:

terraform/modules/
  governance/
  hub-network/
  spoke-network/
  network-security/
  shared-services/
  storage/
  log-analytics/
  diagnostic_settings/
  activity-log/
  flow-logs/
  nsg-flow-logs/
  jump-aci/
  jumphost-vm/


Each module contains:

- `main.tf` — core resources  
- `variables.tf` — inputs  
- `outputs.tf` — exported values  
- `README.md` — module‑level documentation (where present)

### Module Responsibilities (High‑Level)

- **governance** — subscription‑scoped policy, RBAC, tagging requirements  
- **hub-network** — hub VNet, subnets, NSGs, peering  
- **spoke-network** — workload VNet, subnets, isolation  
- **network-security** — NSG rules and secure network defaults  
- **shared-services** — Key Vault, optional Log Analytics, platform services  
- **storage** — storage accounts for platform/workload use  
- **log-analytics** — standalone Log Analytics workspace module  
- **diagnostic_settings** — diagnostic settings for supported resources  
- **activity-log** — subscription Activity Log export  
- **flow-logs / nsg-flow-logs** — NSG flow logs (v2)  
- **jump-aci** — ephemeral container‑based jump host  
- **jumphost-vm** — optional VM‑based jump host  

---

## 3. Module Design

All modules follow a consistent pattern:

- minimal inputs  
- secure defaults  
- no public IPs  
- TLS enforcement where applicable  
- optional diagnostics controlled via variables  
- outputs limited to what other modules require  

This consistency improves readability and maintainability.

---

## 4. Providers and Authentication

The root module defines all providers, including:

- AzureRM  
- AzureAD (if required)  
- Random (optional)

Authentication is handled through:

- GitHub Actions using OIDC  
- Azure CLI for local development  
- no long‑lived credentials  

Provider configuration follows least‑privilege principles.

---

## 5. State Management

The project currently uses local state for simplicity.  
The structure supports future migration to remote state using:

- Azure Storage Account  
- Blob lease‑based state locking  
- private endpoints and firewall rules  

Remote state can be introduced without changing module structure.

---

## 6. Variable and Output Conventions

The root module passes shared variables to all child modules, including:

- `prefix`  
- `environment`  
- `location`  
- `tags`  

Modules expose only the outputs required by other modules or the root configuration.

Naming and tagging conventions are defined in:  
`/docs/reference/naming-and-tagging-standards.md`

---

## 7. CI/CD Integration

The GitHub Actions pipeline interacts only with the root module. It performs:

- formatting and validation  
- planning  
- manual approval  
- apply  

Security‑sensitive changes (network, identity, policy) receive explicit review during approval.

For full CI/CD details, see:  
`/docs/architecture/automation-and-ci-cd.md`.

---

## 8. Extensibility

The Terraform structure is designed to scale as the environment grows.  
Future enhancements may include:

- additional spokes or workloads  
- private DNS and advanced networking modules  
- Defender for Cloud or security baseline modules  
- environment‑specific root modules (dev/test/prod)  
- policy‑as‑code modules for enterprise governance  
- modules implementing Microsoft Cloud Security Benchmark (MCSB) controls  

The current structure provides a clean, minimal foundation that supports these future capabilities.


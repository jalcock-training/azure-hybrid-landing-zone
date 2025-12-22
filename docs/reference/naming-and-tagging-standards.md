# Naming and Tagging Standards

This document defines the naming and tagging standards used in the Azure Hybrid Landing Zone project. Consistent naming and tagging improve clarity, governance, automation, and operational efficiency. These standards follow Azure landing zone best practices while remaining simple and appropriate for a minimal, cost‑efficient environment.

## 1. Purpose of Naming and Tagging Standards

The goals of these standards are to:

- Provide clear, predictable resource names
- Support governance and policy enforcement
- Improve readability and operational clarity
- Enable cost management and reporting
- Ensure consistency across cloud and hybrid resources
- Support automation and CI/CD workflows

These standards apply to all Azure resources deployed through Terraform.

## 2. Naming Standard

The naming convention uses a structured, readable pattern that balances clarity with brevity. The general format is:

<prefix>-<resource>-<location>-<environment>


Where:

- **prefix**  
  A short identifier for the project (e.g., `ahlz` for Azure Hybrid Landing Zone).

- **resource**  
  A short code representing the resource type (e.g., `vnet`, `kv`, `la`, `app`).

- **location**  
  Azure region abbreviation (e.g., `ausse` for Australia Southeast).

- **environment**  
  Logical environment identifier (e.g., `dev`, `test`, `prod`).  
  For this project, a single environment such as `dev` is sufficient.

### Examples

- `ahlz-vnet-hub-ausse-dev`  
- `ahlz-vnet-spoke-ausse-dev`  
- `ahlz-kv-platform-ausse-dev`  
- `ahlz-la-platform-ausse-dev`  
- `ahlz-app-web-ausse-dev`

### Resource Type Abbreviations

Common resource abbreviations include:

- `vnet` — Virtual Network  
- `subnet` — Subnet  
- `kv` — Key Vault  
- `la` — Log Analytics workspace  
- `app` — App Service  
- `sa` — Storage Account  
- `rg` — Resource Group  
- `vm` — Virtual Machine (Arc‑enabled or Azure‑native)

These abbreviations keep names concise and readable.

## 3. Resource Group Naming

Resource groups follow a similar pattern:

<prefix>-rg-<purpose>-<environment>


Examples:

- `ahlz-rg-platform-dev`
- `ahlz-rg-network-dev`
- `ahlz-rg-workload-dev`

This structure clearly separates platform, network, and workload resources.

## 4. Tagging Standard

Tags provide classification, cost management, and governance metadata. All resources must include the following tags:

- **Environment**  
  Identifies the logical environment (e.g., `dev`).

- **Owner**  
  Identifies the responsible person or team (e.g., `james`).

- **Project**  
  Identifies the project or service (e.g., `azure-hybrid-landing-zone`).

- **CostCentre**  
  Identifies the cost centre or billing group (optional for this project).

- **Application**  
  Identifies the application or workload (e.g., `sample-webapp`).

### Example Tag Set

Environment = "dev"
Owner       = "james"
Project     = "azure-hybrid-landing-zone"
Application = "sample-webapp"
CostCentre  = "demo"


These tags support governance, reporting, and operational clarity.

## 5. Tag Enforcement

Azure Policy enforces:

- Required tags  
- Allowed tag values (optional)  
- Automatic remediation for missing tags (optional)  

This ensures consistent tagging across cloud and hybrid resources.

## 6. Hybrid Resource Naming

Azure Arc–enabled servers follow the same naming pattern as Azure‑native resources:

ahlz-vm-<hostname>-onprem-dev


Example:

- `ahlz-vm-web01-onprem-dev`

This ensures hybrid assets appear consistent within Azure Resource Manager.

## 7. Extensibility

The naming and tagging standards are designed to scale as the environment grows. Future enhancements may include:

- Additional environment identifiers (e.g., `test`, `prod`)
- More granular application or service tags
- Region‑specific naming variations
- Automated tag inheritance through policy
- Naming conventions for additional resource types

The current standards provide a clear, minimal foundation suitable for this project.


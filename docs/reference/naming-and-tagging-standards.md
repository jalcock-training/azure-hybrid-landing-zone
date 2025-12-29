# Naming and Tagging Standards

This document defines the naming and tagging standards used in the Azure Hybrid Landing Zone project.  
These standards reflect the actual Terraform implementation and ensure consistency, clarity, and operational simplicity across all resources.

For details on governance and policy enforcement, see:  
`/docs/architecture/governance-and-policy.md`

---

## 1. Purpose of Naming and Tagging Standards

The goals of these standards are to:

- Provide clear, predictable resource names
- Support governance and policy enforcement
- Improve readability and operational clarity
- Enable cost management and reporting
- Ensure consistency across cloud and hybrid resources
- Support automation and CI/CD workflows

These standards apply to all Azure resources deployed through Terraform.

---

## 2. Naming Standard

The naming convention used in this project follows a simple, consistent pattern aligned with the actual Terraform implementation.

General format:

<prefix>-<component>-<environment>

Where:

- **prefix**  
  Short identifier for the project (e.g., `ahlz` for Azure Hybrid Landing Zone).

- **component**  
  Logical component name (e.g., `hub`, `spoke`, `kv`, `sa`, `app`, `arc`).

- **environment**  
  Logical environment identifier (e.g., `dev`).  
  This project uses a single environment (`dev`).

### Examples (matching Terraform implementation)

- `ahlz-hub-dev`
- `ahlz-spoke-dev`
- `ahlz-kv-dev`
- `ahlz-sa-dev`
- `ahlz-app-dev`
- `ahlz-arc-dev`

### Notes

- Region is **not** included in resource names.
- Resource type abbreviations are **not** included unless they are part of the component name.
- Names are intentionally short to maintain readability and avoid Azure length limits.

---

## 3. Resource Group Naming

Resource groups follow a simplified pattern:

<prefix>-rg-<purpose>

Examples:

- `ahlz-rg-platform`
- `ahlz-rg-network`
- `ahlz-rg-workload`

Environment is not included in resource group names in this implementation.

---

## 4. Tagging Standard

Tags provide classification, cost management, and governance metadata.  
All resources must include the following tags:

- **Environment**  
  Logical environment (e.g., `dev`)

- **Owner**  
  Responsible person or team (e.g., `james`)

- **Project**  
  Project or service name (e.g., `azure-hybrid-landing-zone`)

- **Application**  
  Application

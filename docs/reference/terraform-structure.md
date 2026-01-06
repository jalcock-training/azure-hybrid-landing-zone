# Terraform Structure

## Overview

The Terraform codebase is organised into clear layers:

- Platform: core landing zone services (hub, shared services, identity, governance)
- Spokes: application landing zones attached to the hub
- Hybrids: non-Azure workloads connected into the platform (libvirt/KVM)
- Modules: reusable building blocks consumed by platform, spokes, and hybrids

This mirrors real-world landing zone patterns and keeps concerns clearly separated.

## Layers

### Platform Layer

Located under `platform/`:

- `platform/hub`:
  - Hub VNet and subnets
  - Network security (NSGs)
  - Jump ACI and jumphost access
  - Flow logs and diagnostics
- `platform/shared-services`:
  - Shared services resource group
  - Key Vault and Storage
  - Private endpoints
  - Shared-services diagnostics and RBAC
- `platform/identity`:
  - Hybrid identity (Azure AD App + Service Principal)
  - RBAC assignments for Key Vault and Storage
- `platform/governance`:
  - Governance resource group
  - Policy assignments (allowed locations, tags, etc.)
  - Activity log export
  - Diagnostic storage

### Spoke Layer

Located under `spokes/`:

- `spokes/spoke01`:
  - Spoke VNet and subnets
  - NSGs
  - Peering back to the hub
  - Workload VM in the spoke using the workload-vm module

Spokes demonstrate how application workloads would land in the environment while still using shared services and hub connectivity.

### Hybrid Layer

Located under `hybrids/`:

- `hybrids/hybrid02-prereqs`:
  - Azure-side prerequisites for Hybrid02
  - Secrets and storage content required for bootstrap
- `hybrids/hybrid01`:
  - Libvirt-based VM providing network connectivity from Azure towards the libvirt network
- `hybrids/hybrid02`:
  - Libvirt-based workload VM
  - Cloud-init bootstrap using hybrid identity to pull secrets/content from Azure

This layer demonstrates hybrid connectivity and identity-driven bootstrap for non-Azure workloads.

### Modules Layer

Located under `modules/`:

- Networking:
  - `hub-network`
  - `spoke-network`
  - `network-security`
- Security and governance:
  - `governance`
  - `nsg-flow-logs`
- Diagnostics and monitoring:
  - `activity-log`
  - `diag-storage`
  - `diagnostic_settings`
  - `log-analytics`
- Compute and access:
  - `jump-aci`
  - `jumphost-vm`
  - `workload-vm`
  - `libvirt-hybrid-vm`
- Shared services:
  - `shared-services`
  - `storage`

## Rationale

This structure:

- Separates platform, spokes, and hybrid workloads
- Makes module dependencies explicit
- Supports incremental deployment (platform → spokes → hybrids)
- Matches typical enterprise landing zone layouts while staying approachable for a portfolio project


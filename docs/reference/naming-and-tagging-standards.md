# Naming and Tagging Standards

## Overview

Consistent naming and tagging ensures clarity, governance compliance, and operational efficiency across the landing zone.

## Naming Standards

### Resource Groups
Format: `rg-{purpose}`  
Example: `rg-shared-services`

### VNets
Format: `vnet-{purpose}`  
Example: `vnet-hub`

### Subnets
Format: `snet-{purpose}`  
Example: `snet-private-endpoints`

### Key Vault
Format: `kv-{purpose}`  
Example: `kv-shared`

### Storage Accounts
Format: `st{unique}{purpose}`  
Example: `stjames123shared`

### VMs
Format: `{prefix}-{role}`  
Example: `ahlz-hybrid01-endpoint`

## Tagging Standards

### Required Tags
- `owner`
- `environment`
- `costcenter`
- `project`

### Recommended Tags
- `createdBy`
- `managedBy`
- `lifecycle`

## Rationale

Naming and tagging standards:

- Improve readability
- Support governance policies
- Enable automation
- Simplify cost management


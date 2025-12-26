# Shared Services Module

This module deploys shared platform services for the Azure Hybrid Landing Zone.

## Features

- Optional **Log Analytics workspace** (disabled by default)
- Optional **Azure Key Vault** configured with:
  - Soft delete and purge protection enabled
  - Public network access disabled
  - Network ACLs restricted to specified subnets
  - RBAC-based access enabled (`enable_rbac_authorization = true`)
- Optional **Key Vault private endpoint** in a specified subnet

All features are **opt-in** and secure-by-default.

## Inputs

- **location**: Azure region for shared services  
- **resource_group_name**: Resource group name  
- **prefix**: Naming prefix (e.g., `ahlz-dev`)  
- **tags**: Map of tags  

Feature toggles:

- **enable_log_analytics** (bool, default `false`)  
- **enable_key_vault** (bool, default `false`)  
- **enable_key_vault_private_endpoint** (bool, default `false`)  

Network configuration:

- **key_vault_allowed_subnet_ids**: List of subnet IDs allowed to access Key Vault  
- **key_vault_private_endpoint_subnet_id**: Subnet ID for Key Vault private endpoint  

## Outputs

- **log_analytics_workspace_id**, **log_analytics_workspace_name**  
- **key_vault_id**, **key_vault_name**, **key_vault_uri**

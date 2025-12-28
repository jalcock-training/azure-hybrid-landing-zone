# NSG Flow Logs v2 Module

This module enables NSG Flow Logs v2 and Traffic Analytics for any Network Security Groups (NSGs) passed into it.  
It supports shared-services NSG today, and app/data NSGs later as the landing zone expands.

Flow Logs v2 provide visibility into network traffic patterns, security posture, and potential lateral movement across workloads.  
Traffic Analytics sends enriched flow data to Log Analytics for query, dashboards, and threat detection.

---

## Features

- Enables NSG Flow Logs v2 for any number of NSGs  
- Supports Traffic Analytics with a 10‑minute interval  
- Stores raw flow logs in a central storage account  
- Sends analytics data to Log Analytics workspace  
- Fully modular and future‑proof (add NSGs later without refactoring)  
- Includes feature toggle for easy enable/disable  
- Uses `for_each` for clean scaling across multiple NSGs  

---

## Inputs

| Name | Type | Description |
|------|------|-------------|
| `prefix` | string | Prefix used for naming Flow Log resources. |
| `enable_nsg_flow_logs` | bool | Feature toggle to enable or disable Flow Logs v2. |
| `nsg_ids` | list(string) | List of NSG IDs to enable Flow Logs for (shared-services now, app/data later). |
| `network_watcher_name` | string | Name of the Network Watcher instance. |
| `network_watcher_rg` | string | Resource group containing the Network Watcher. |
| `storage_account_id` | string | Storage account ID for raw flow logs. |
| `log_analytics_workspace_id` | string | Log Analytics workspace ID for Traffic Analytics. |

---

## Outputs

| Name | Description |
|------|-------------|
| `nsg_flow_log_ids` | Map of NSG Flow Log resource IDs, keyed by NSG ID. |

---

## Example Usage

```hcl
module "nsg_flow_logs" {
  source = "../modules/nsg-flow-logs"

  prefix                     = var.prefix
  enable_nsg_flow_logs       = var.enable_nsg_flow_logs
  nsg_ids                    = [module.hub_network.shared_services_nsg_id]
  network_watcher_name       = module.hub_network.network_watcher_name
  network_watcher_rg         = module.hub_network.network_watcher_rg
  storage_account_id         = module.storage.storage_account_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

Later, when app/data spokes are created:

nsg_ids = [
  module.hub_network.shared_services_nsg_id,
  module.app_network.app_nsg_id,
  module.data_network.data_nsg_id
]


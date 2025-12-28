# NSG Flow Logs Module (AzureRM v4)

This module enables NSG Flow Logs using **Azure Monitor Diagnostic Settings**, which is the correct and supported approach in AzureRM v4.  
Legacy Network Watcher Flow Log resources (`azurerm_network_watcher_flow_log` and `_v2`) were removed in v4, and Diagnostic Settings is now the unified mechanism for exporting NSG flow data.

Flow Logs are sent to:
- A Storage Account (raw flow logs)
- A Log Analytics Workspace (Traffic Analytics and queryable flow data)

The module accepts a list of NSG resource IDs and applies the same diagnostic configuration to each one.

---

## Features

- Enables **NetworkSecurityGroupFlowEvent** logs for each NSG
- Sends logs to both **Storage** and **Log Analytics**
- No dependency on Network Watcher (not required in AzureRM v4)
- Supports feature toggling via `enable_nsg_flow_logs`
- Works for hub, spoke, or standalone NSGs

---

## Usage

```hcl
module "nsg_flow_logs" {
  source = "./modules/nsg-flow-logs"

  prefix                     = var.prefix
  enable_nsg_flow_logs       = var.enable_nsg_flow_logs

  nsg_ids = [
    module.hub_network.nsg_ids["shared_services"]
  ]

  storage_account_id         = module.storage.storage_account_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
```

---

## Inputs

| Name                        | Type          | Description |
|-----------------------------|---------------|-------------|
| `prefix`                    | string        | Naming prefix for diagnostic settings |
| `enable_nsg_flow_logs`      | bool          | Feature toggle to enable/disable flow logs |
| `nsg_ids`                   | list(string)  | List of NSG resource IDs to enable flow logs on |
| `storage_account_id`        | string        | Storage Account resource ID for raw flow logs |
| `log_analytics_workspace_id`| string        | Log Analytics Workspace resource ID |

---

## Outputs

| Name               | Description |
|--------------------|-------------|
| `nsg_flow_log_ids` | Map of diagnostic setting IDs keyed by NSG name |

---

## Notes

- Traffic Analytics is automatically enabled when flow logs are sent to Log Analytics.
- No Network Watcher resources are required in AzureRM v4.
- Diagnostic Settings is the long‑term supported mechanism for NSG Flow Logs.

---

## Example: Adding more NSGs later

```hcl
nsg_ids = [
  module.hub_network.nsg_ids["shared_services"],
  module.app_network.nsg_ids["app"],
  module.data_network.nsg_ids["data"]
]
```

---

## Compatibility

- **AzureRM provider:** v4.x and above  
- **Terraform:** 1.5+ recommended


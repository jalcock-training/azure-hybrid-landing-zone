# Activity Log Export Module

This module enables **subscription‑level Activity Log export** to a Log Analytics workspace.  
Activity Logs capture control‑plane operations such as resource creation, deletion, RBAC changes, policy assignments, and administrative actions. Exporting these logs is a core requirement for Azure security baselines and provides essential auditing visibility.

This module is free‑tier friendly and uses a feature toggle to enable or disable Activity Log export.

---

## Features

- Exports Azure Activity Logs to Log Analytics  
- Covers all major Activity Log categories:
  - Administrative  
  - Security  
  - ServiceHealth  
  - Alert  
  - Recommendation  
  - Policy  
  - ResourceHealth  
- Subscription‑level scope  
- Clean, modular design  
- Optional enable/disable via feature toggle  
- No impact on existing resources  

---

## Usage

```hcl
module "activity_log" {
  source = "./modules/activity-log"

  prefix                       = var.prefix
  subscription_id              = var.subscription_id
  log_analytics_workspace_id   = module.log_analytics.log_analytics_workspace_id
  enable_activity_log_export   = var.enable_activity_log_export
}
```

---

## Inputs

| Name                         | Type   | Description                                                   | Default |
|------------------------------|--------|---------------------------------------------------------------|---------|
| `prefix`                     | string | Prefix used for naming resources                              | n/a     |
| `subscription_id`            | string | Subscription ID to export Activity Logs from                  | n/a     |
| `log_analytics_workspace_id` | string | Log Analytics workspace ID to receive Activity Logs           | n/a     |
| `enable_activity_log_export` | bool   | Feature toggle to enable or disable Activity Log export       | `true`  |

---

## Outputs

| Name                                      | Description                                      |
|-------------------------------------------|--------------------------------------------------|
| `activity_log_diagnostic_setting_id`      | ID of the Activity Log diagnostic setting        |

---

## Notes

- This module configures a single `azurerm_monitor_diagnostic_setting` at the subscription scope.  
- No resources are created if `enable_activity_log_export` is set to `false`.  
- This module requires an existing Log Analytics workspace.  

---

## Compliance

Enabling Activity Log export contributes to:

- Microsoft Cloud Security Benchmark  
- CIS Azure Foundations Benchmark  
- NIST 800‑53  
- Azure Secure Score  

---

## License

This module is part of the Azure Hybrid Landing Zone project and follows the repository’s licensing model.


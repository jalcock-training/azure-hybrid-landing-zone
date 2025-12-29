# ------------------------------------------------------------
# Root Module
# ------------------------------------------------------------

/*
  Root Module: Azure Hybrid Landing Zone
  --------------------------------------
  This directory defines the subscription‑scoped landing zone using
  modular Terraform components.

  All infrastructure is declared in logically separated files:
    - governance.tf
    - networking.tf
    - network_security.tf
    - shared_services.tf
    - storage.tf
    - compute.tf
    - diagnostics.tf
    - logging.tf
    - flow_logs.tf

  This root module intentionally contains no resources. 

  Future enterprise features (management groups, subscription vending,
  platform automation) will be implemented in a separate project.
*/


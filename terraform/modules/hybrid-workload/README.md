# Hybrid Workload Module

This module prepares Azure resources for an on-premises VM that consumes
certificates and content from the landing zone.

It creates:

- a private key and self-signed certificate
- Key Vault secrets for both
- a storage blob containing index.html
- a service principal for the hybrid VM
- RBAC assignments for Key Vault + Storage

The on-prem VM uses these outputs to authenticate and bootstrap itself.


# Identity Architecture

## Overview

The identity layer provides a dedicated Azure AD application and service principal used by hybrid workloads running outside Azure. This identity is consumed by Hybrid02 to authenticate securely to Azure services without embedding credentials in VM images.

The identity layer is implemented in /platform/identity and is intentionally isolated from networking and shared services.

## Components

- Azure AD Application
- Service Principal
- Client secret
- RBAC assignments for Key Vault and Storage
- Terraform outputs consumed by Hybrid02 via remote state

## Design Rationale

- Keeps identity concerns separate from networking and shared services
- Ensures least-privilege access to Azure resources
- Enables secure bootstrap of hybrid workloads
- Avoids storing credentials in VM images or cloud-init templates

## RBAC Assignments

Hybrid identity receives:

- Key Vault: get, list, read secrets
- Storage Account: read blob content
- No write or administrative permissions

## Why Hybrid01 Does Not Use Identity

Hybrid01 is an SSH relay only.  
It does not access Azure resources and therefore does not require identity.

## Outputs

The identity module exports:

- client_id
- client_secret
- tenant_id
- subscription_id

These values are consumed by Hybrid02 during cloud-init bootstrap.


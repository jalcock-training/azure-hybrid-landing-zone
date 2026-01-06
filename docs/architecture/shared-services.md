# Shared Services Architecture

## Overview

Shared services provide centralised secrets, content, and private connectivity for hybrid workloads. These services are deployed in the shared-services resource group.

## Components

- Azure Key Vault
- Azure Storage Account
- Private endpoints for Key Vault and Storage
- Private DNS zones for Key Vault and Storage

## Security Configuration

- Public network access disabled
- TLS 1.2+ enforced
- Soft delete and purge protection enabled on Key Vault
- Private-endpoint-only access

## RBAC

Hybrid identity receives:

- Key Vault: read-only secret access
- Storage: read-only blob access

## Rationale

- Centralises sensitive data
- Ensures all access is private and identity-driven
- Avoids exposing PaaS services to the public internet
- Supports hybrid workloads securely


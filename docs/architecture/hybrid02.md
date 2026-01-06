# Hybrid02 Architecture

## Purpose

Hybrid02 is a hybrid workload VM that retrieves TLS material and content from Azure using hybrid identity. It exposes a secure HTTPS endpoint configured during cloud-init.

## Key Characteristics

- Uses hybrid identity for Azure authentication
- Cloud-init bootstrap retrieves secrets and content
- Downloads TLS certificate and key from Key Vault
- Downloads application content from Storage
- Configures nginx with TLS
- Static IP (192.168.122.102)
- Depends on hybrid02-prereqs for secret creation

## Cloud-Init Bootstrap Flow

1. Install Azure CLI
2. Authenticate using hybrid identity (client_id + secret)
3. Retrieve certificate and key from Key Vault
4. Retrieve content from Storage
5. Configure nginx with TLS
6. Start HTTPS endpoint

## Rationale

- Demonstrates secure hybrid identity usage
- Implements a private-endpoint-first workload pattern
- Shows how to bootstrap workloads without embedding secrets
- Provides a real, testable HTTPS endpoint


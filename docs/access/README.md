# Access Patterns

## Overview

Access to the landing zone and hybrid workloads is intentionally restricted. There is a clear separation between operator access and hybrid connectivity into the libvirt environment.

## Operator Access Path

The primary operator path is:

1. Jump ACI in the hub VNet
2. Jumphost VM in the hub VNet
3. From the jumphost, access to:
   - Spoke workloads
   - Shared services
   - (Optionally) the hybrid connectivity path towards Hybrid02

### Components

- Jump ACI:
  - Azure Container Instance
  - No public IP
  - Accessed using Azure AD credentials and Azure CLI
- Jumphost VM:
  - Deployed in the hub VNet
  - SSH-only access
  - Acts as the central operational access point

## Hybrid Connectivity Path

Hybrid connectivity is provided via Hybrid01 and the libvirt network:

- Hybrid01:
  - Minimal VM that bridges from the Azure side into the libvirt network
  - No public IP and no Azure identity
  - Used to provide network connectivity, not as a primary operator entry point
- Hybrid02:
  - Workload VM running on libvirt
  - Retrieves secrets and content from Azure using hybrid identity
  - Exposes a TLS-secured endpoint for demonstration purposes

## Security Controls

- No public IPs on jump ACI, jumphost, Hybrid01, or Hybrid02
- SSH key-based access only
- NSGs enforce deny-by-default on inbound rules
- Private-endpoint-only access to Azure PaaS services
- Identity-driven access to Azure using Azure AD and hybrid identity

## Rationale

This pattern:

- Separates operator access from hybrid network connectivity
- Keeps the attack surface small and well-defined
- Demonstrates realistic operational patterns (jumpbox + ACI) and hybrid connectivity in the same landing zone


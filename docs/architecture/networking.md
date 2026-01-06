# Networking Architecture

## Overview

The networking layer provides a secure hub-and-spoke foundation with private-endpoint-first connectivity and no public ingress.

## Components

- Hub VNet
- Shared-services subnet
- ACI jumpbox subnet
- Private-endpoints subnet
- NSGs on all subnets
- VNet peering (hub ↔ spoke)

## Security Controls

- Deny-all inbound rules
- No public IPs on any VMs
- Private endpoints for Key Vault and Storage
- NSG rules restrict lateral movement

## DNS

- Private DNS zone for Key Vault
- Private DNS zone for Storage (Blob and File)
- VNet links
- Dependency ordering to avoid race conditions

## Rationale

- Ensures all Azure services are accessed privately
- Reduces attack surface
- Supports hybrid workloads without exposing public endpoints


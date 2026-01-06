# Application Workload Architecture

## Overview

Application workloads in this landing zone are represented in two ways:

- Azure-based workloads deployed into spokes using the workload-vm module
- Hybrid workloads running on libvirt/KVM (Hybrid02) that consume Azure services using hybrid identity

This demonstrates both a standard spoke-based landing zone pattern and a hybrid pattern.

## Azure Workloads (Spoke01)

Spoke01 uses:

- A spoke VNet peered to the hub
- NSGs to control inbound and outbound traffic
- A workload VM deployed using the `workload-vm` module

The workload VM can:

- Reach shared services (Key Vault, Storage) via the hub and private endpoints
- Be accessed via the jumphost in the hub

## Hybrid Workload (Hybrid02)

Hybrid02:

- Runs on libvirt/KVM
- Uses hybrid identity to authenticate to Azure
- Retrieves TLS certificate and key from Key Vault
- Retrieves content from Storage
- Configures nginx with TLS via cloud-init

## Rationale

By combining Azure workloads in spokes with a hybrid workload in libvirt, the landing zone:

- Demonstrates a realistic hub-and-spoke application pattern
- Demonstrates a hybrid connectivity and identity pattern
- Shows how shared services can be consumed by both Azure and non-Azure workloads


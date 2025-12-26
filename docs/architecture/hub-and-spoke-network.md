# Hub and Spoke Network Design

This document describes the network architecture used in the Azure Hybrid Landing Zone project. The environment follows a hub‑and‑spoke topology, a common enterprise pattern that provides clear separation between shared platform services and workload‑specific resources. The design is intentionally minimal to control cost while still demonstrating scalable and secure network architecture.

## Network Security Overview
The network design follows a security-first approach aligned with Azure best practices.
Key security characteristics include:
- No public IPs assigned to compute resources
- NSGs enforcing deny‑all inbound rules on all subnets
- Private endpoints securing access to Key Vault, Storage, and shared services
- VNet peering restricted to required traffic flows only
- Jump‑ACI pattern eliminating public SSH/RDP access
These controls ensure the network remains isolated, predictable, and cost‑efficient.

## 1. Network Topology Overview

The network is organised into two primary virtual networks:

- Hub Virtual Network
  Hosts shared services and centralised management components.

- Spoke Virtual Network
  Hosts the application workload and any workload‑specific resources.

The hub and spoke networks are connected using VNet peering, allowing controlled communication while maintaining isolation between workloads.
All communication occurs over private IP space, with no public ingress required for platform or workload resources.

## 2. Hub Virtual Network

The hub network represents the platform layer of the environment. It provides shared services that support monitoring, governance, and connectivity.

### Key Components

- Hub Virtual Network
  - A central VNet that acts as the connectivity and services core.

- Subnets
  - Shared Services subnet
  - Optional Azure Bastion subnet
  - Optional Azure Firewall subnet (not deployed in this project to minimise cost)

- Shared Services
  - Log Analytics workspace for centralised monitoring (optional or future)
  - Azure Key Vault (Standard tier) for secret management
  - Optional Automation Account or other platform services
  - Private endpoints securing access to Key Vault and Storage

### Design Considerations

- The hub is intentionally lightweight to keep the environment cost‑effective.
- Shared services are deployed once and consumed by all spokes.
- No user‑defined routes or network virtual appliances are required at this stage.
- All hub resources reside within the same subscription as the spoke to maintain free‑tier compatibility.
- NSGs enforce deny‑all inbound rules on hub subnets, with only required traffic allowed.
- No public IPs are assigned to any hub resources, reducing attack surface.

## 3. Spoke Virtual Network

The spoke network hosts the example application workload. It is isolated from other workloads and communicates with the hub through VNet peering.

### Key Components

- Spoke Virtual Network
  - A workload‑specific VNet that contains application resources.

- Subnets
  - Application subnet
  - Optional Private Endpoint subnet

- Application Resources
  - Azure App Service (Free tier)
  - Storage account for application assets or logs
  - Optional private endpoints for secure access to platform services
  - No public IPs assigned to compute resources within the spoke

### Design Considerations

- The spoke is isolated from other workloads and from the hub except where explicitly allowed.
- The application does not require inbound public access; App Service handles external access.
- Diagnostic settings forward logs to the shared Log Analytics workspace when enabled.
- NSGs restrict inbound and outbound traffic to only what is required for the workload.

## 4. Connectivity Between Hub and Spoke

Hub and spoke networks are connected using VNet peering, which provides:

- Low‑latency, high‑bandwidth communication
- No need for gateways or VPNs
- Separate control planes for each VNet
- Clear separation of platform and workload responsibilities

Peering is configured as non‑transitive, meaning spokes cannot communicate with each other unless explicitly peered.
Peering is configured without gateway transit or forwarded traffic, ensuring traffic flows remain predictable and controlled.

## 5. Security and Isolation

The network design supports strong isolation between platform and workload layers:

- Network Security Groups (NSGs) control traffic at the subnet level.
- No inbound public access is required for the hub or spoke VNets.
- Private endpoints can be added later to enhance security without redesigning the network.
- Azure Firewall is intentionally excluded to avoid unnecessary cost but can be added as a future enhancement.
- Security controls are applied at the subscription and resource‑group level rather than through management‑group inheritance.
- All administrative access is routed through an ephemeral jump‑ACI, eliminating the need for public SSH or RDP.
- Diagnostic logging is enabled for NSGs, VMs, and platform services to provide visibility into network activity.

## 6. Integration with Hybrid Resources

Azure Arc–enabled servers do not connect directly to the hub or spoke networks. Instead, they integrate through:

- Azure Resource Manager
- Azure Policy
- Optional monitoring via Log Analytics

This allows hybrid resources to participate in governance and monitoring without requiring network connectivity to Azure VNets.
Arc-enabled resources inherit the same policy-driven security controls as cloud resources, ensuring consistent posture across environments.

## 7. Extensibility

The hub‑and‑spoke topology is designed to scale as the project grows. Future enhancements may include:

- Additional spokes for multi‑environment scenarios
- Azure Firewall or third‑party network virtual appliances
- Private DNS zones for centralised name resolution
- ExpressRoute or VPN gateways for enterprise connectivity
- Service endpoints or private endpoints for more secure service access

The current implementation provides a minimal, cost‑efficient foundation while remaining aligned with enterprise best practices.



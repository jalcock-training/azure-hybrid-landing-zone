# Hub and Spoke Network Design

This document describes the network architecture used in the Azure Hybrid Landing Zone project. The environment follows a hub‑and‑spoke topology, a common enterprise pattern that provides clear separation between shared platform services and workload‑specific resources. The design is intentionally minimal to control cost while still demonstrating scalable and secure network architecture.

## 1. Network Topology Overview

The network is organised into two primary virtual networks:

- **Hub Virtual Network**  
  Hosts shared services and centralised management components.

- **Spoke Virtual Network**  
  Hosts the application workload and any workload‑specific resources.

The hub and spoke networks are connected using VNet peering, allowing controlled communication while maintaining isolation between workloads.

## 2. Hub Virtual Network

The hub network represents the platform layer of the environment. It provides shared services that support monitoring, governance, and connectivity.

### Key Components

- **Hub Virtual Network**  
  A central VNet that acts as the connectivity and services core.

- **Subnets**  
  - Shared Services subnet  
  - Optional Azure Bastion subnet  
  - Optional Azure Firewall subnet (not deployed in this project to minimise cost)

- **Shared Services**  
  - Log Analytics workspace for centralised monitoring  
  - Azure Key Vault (Standard tier) for secret management  
  - Optional Automation Account or other platform services

### Design Considerations

- The hub is intentionally lightweight to keep the environment cost‑effective.
- Shared services are deployed once and consumed by all spokes.
- No user‑defined routes or network virtual appliances are required at this stage.

## 3. Spoke Virtual Network

The spoke network hosts the example application workload. It is isolated from other workloads and communicates with the hub through VNet peering.

### Key Components

- **Spoke Virtual Network**  
  A workload‑specific VNet that contains application resources.

- **Subnets**  
  - Application subnet  
  - Optional Private Endpoint subnet

- **Application Resources**  
  - Azure App Service (Free tier)  
  - Storage account for application assets or logs  
  - Optional private endpoints for secure access to platform services

### Design Considerations

- The spoke is isolated from other workloads and from the hub except where explicitly allowed.
- The application does not require inbound public access; App Service handles external access.
- Diagnostic settings forward logs to the shared Log Analytics workspace.

## 4. Connectivity Between Hub and Spoke

Hub and spoke networks are connected using **VNet peering**, which provides:

- Low‑latency, high‑bandwidth communication  
- No need for gateways or VPNs  
- Separate control planes for each VNet  
- Clear separation of platform and workload responsibilities

Peering is configured as non‑transitive, meaning spokes cannot communicate with each other unless explicitly peered.

## 5. Security and Isolation

The network design supports strong isolation between platform and workload layers:

- Network Security Groups (NSGs) control traffic at the subnet level.
- No inbound public access is required for the hub or spoke VNets.
- Private endpoints can be added later to enhance security without redesigning the network.
- Azure Firewall is intentionally excluded to avoid unnecessary cost but can be added as a future enhancement.

## 6. Integration with Hybrid Resources

Azure Arc–enabled servers do not connect directly to the hub or spoke networks. Instead, they integrate through:

- Azure Resource Manager  
- Azure Policy  
- Optional monitoring via Log Analytics  

This allows hybrid resources to participate in governance and monitoring without requiring network connectivity to Azure VNets.

## 7. Extensibility

The hub‑and‑spoke topology is designed to scale as the project grows. Future enhancements may include:

- Additional spokes for multi‑environment scenarios  
- Azure Firewall or third‑party network virtual appliances  
- Private DNS zones for centralised name resolution  
- ExpressRoute or VPN gateways for enterprise connectivity  
- Service endpoints or private endpoints for more secure service access  

The current implementation provides a minimal, cost‑efficient foundation while remaining aligned with enterprise best practices.



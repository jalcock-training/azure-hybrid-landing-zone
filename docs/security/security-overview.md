# Security Overview

This document defines the central security model for the Azure Hybrid Landing Zone.
All module‑level documentation refers back to this file for security controls.

It covers:

- Network segmentation
- Network Security Groups (NSGs)
- Route tables
- Private endpoints
- DNS zone strategy
- Identity and access
- Logging and monitoring
- Hub/spoke trust boundaries
- Cross‑module dependencies

This file is the single source of truth for all security behaviour across the platform.

---

## 1. Network Segmentation Model

The landing zone uses a hub‑and‑spoke topology.

### Hub VNet
- Shared Services subnet
- ACI subnet
- Private Endpoints subnet
- Azure Firewall subnet (reserved)
- Gateway subnet (reserved)

### Spoke VNet
- App subnet
- Data subnet
- Private Endpoints subnet

### Segmentation Principles
- Subnets are isolated by default
- Only required east‑west flows are allowed
- No direct internet ingress
- No direct internet egress
- Private endpoints are isolated in a dedicated subnet
- ACI is isolated but allowed to reach the jump VM

---

## 2. Network Security Groups (NSGs)

NSGs are applied per subnet.
Each subnet receives its own NSG with a consistent rule set.

### Inbound Rules
- Allow VNet → VNet
- Allow Azure Load Balancer
- Deny all inbound (catch‑all)

### Outbound Rules
- Allow VNet outbound
- Deny all outbound (internet egress blocked)

### Subnet‑Specific Behaviour
- Private Endpoints subnet: fully locked down
- ACI subnet: locked down; allowed to reach the jump VM via VNet rule
- Shared Services subnet: same baseline rules

All NSG behaviour is defined centrally in the `network-security` module.

---

## 3. Route Tables

Each subnet receives its own route table.

### Hub Routes
- Route to Spoke (VnetLocal)
- Deny internet (0.0.0.0/0 → None)

### Spoke Routes
- No custom routes by default
- Future firewall integration will update this

---

## 4. Private Endpoint Security

Private endpoints are deployed only in the dedicated `private-endpoints` subnet.

### Security Controls
- Public network access disabled on all PaaS services
- Private DNS zones resolve service endpoints
- NSG denies all inbound/outbound except VNet
- Route table denies internet egress
- No service delegation
- No UDRs that break private endpoint routing

### Services Using Private Endpoints
- Key Vault
- Storage (Blob + File)

---

## 5. Private DNS Zones

DNS zones are created once in shared‑services and linked to the hub VNet.

### Zones
- privatelink.vaultcore.azure.net
- privatelink.blob.core.windows.net
- privatelink.file.core.windows.net

### DNS Strategy
- Zones created in shared‑services
- Linked to hub VNet
- Storage module consumes zone names and creates VNet links
- No duplication of DNS zones
- No public DNS exposure

---

## 6. Identity and Access Management

### RBAC
- Platform Resource Group:
  - Owner: platform administrators
  - Contributor: automation identities
  - Reader: monitoring identities

### Key Vault Access
- RBAC‑enabled Key Vault
- No access policies
- Access controlled via Azure AD roles
- Network ACLs restrict access to Shared Services and Private Endpoints subnets

### Managed Identities
- Used for automation and ACI workloads
- No secrets stored outside Key Vault

---

## 7. Logging and Monitoring

### Log Analytics Workspace
- Single workspace for the entire landing zone
- Centralised logging and diagnostics
- Retention configurable (default 30 days)

### Activity Log Export
- Subscription‑level export to Log Analytics
- All categories enabled

### Diagnostic Settings
Applied to:
- Storage Account
- Key Vault
- Network resources
- Private endpoints

All logs flow into the same workspace.

---

## 8. Hub/Spoke Trust Boundaries

### Hub
- Contains shared infrastructure
- Fully locked down
- No internet egress
- No inbound from outside VNet
- Private endpoints isolated
- ACI isolated but allowed to reach jump VM

### Spoke
- Application workloads
- No direct internet ingress
- No direct internet egress
- Trusts hub for DNS, logging, shared services, and future firewall routing

---

## 9. Cross‑Module Dependencies

To ensure deterministic ordering:

- Governance → Log Analytics
- Log Analytics → Activity Log Export
- Log Analytics → Diagnostic Settings
- Hub Network → Network Security
- Shared Services → Storage (DNS zones)
- Hub Network → Shared Services (Key Vault PE subnet)

Dependencies are enforced at the module level.

---

## 10. Security Philosophy

The landing zone follows these principles:

- Secure by default
- Least privilege
- Deny by default
- Explicit allow
- Centralised logging
- No public endpoints
- No internet egress
- Deterministic module ordering
- Single source of truth for security controls


# Hub-and-spoke network architecture

This document describes the hub-and-spoke network architecture used in the Azure Hybrid Landing Zone project.  
The design provides a secure, cost‑efficient network foundation aligned with Azure landing zone best practices.

For related documentation, see:
- `/docs/security/security-overview.md`
- `/docs/architecture/shared-services.md`
- `/docs/architecture/landing-zone-design.md`
- `/docs/reference/naming-and-tagging-standards.md`

---

## 1. Purpose of the network architecture

The hub-and-spoke topology provides:

- A centralised hub for shared services  
- A spoke network for workload isolation  
- A controlled path for administrative access  
- A foundation that can scale to additional spokes or services in future phases  

The network is intentionally minimal enough for low‑cost operation while still demonstrating enterprise‑aligned patterns.

---

## 2. High-level topology

The environment uses a single‑region hub-and-spoke topology.

### Hub virtual network

The hub VNet hosts shared platform services and administrative entry points, including:

- Azure Key Vault (with private endpoint)  
- Storage used for platform services (with private endpoint where required)  
- Jumphost VM for interactive administrative access  
- Private DNS zones associated with private endpoints  
- Jump‑ACI connectivity into the hub  

The hub acts as the central control plane for shared connectivity and security.

### Spoke virtual network

The spoke VNet hosts workload resources, including:

- Application services  
- Workload storage accounts  
- Any additional application components  

The spoke is isolated from the hub except for explicitly allowed traffic.

---

## 3. Network security

The network follows a secure‑by‑default model:

- **No direct public IPs** on compute resources in the VNets  
- **NSGs** applied at subnet level with deny‑all inbound rules and minimal explicit allowances  
- **Private endpoints** for platform services such as Key Vault and Storage  
- **Private DNS zones** to support name resolution for private endpoints  
- **No direct inbound connectivity** from the internet to hub or spoke VNets  
- **Controlled administrative access** via Jump‑ACI and a dedicated jumphost VM  

Full security details are documented in:  
`/docs/security/security-overview.md`

---

## 4. Traffic flow

### Outbound traffic

Outbound traffic from workloads and shared services:

- Flows directly to the internet using Azure‑managed outbound IPs  
- Does not traverse a user‑managed firewall or NVA in this phase  
- Can be restricted via NSG rules as needed  

### Inbound traffic

Inbound access is tightly controlled:

- No direct inbound access from the public internet to hub or spoke subnets  
- Administrative access uses a chained model:

  1. An operator authenticates using Azure CLI and OIDC‑based or identity‑based credentials.  
  2. The operator starts a Jump‑ACI container in the hub context.  
  3. From Jump‑ACI, the operator connects to the jumphost VM.  
  4. From the jumphost VM, the operator can reach other resources as permitted by NSGs.

Currently, access from Jump‑ACI to the jumphost VM uses a generic account with shared keys.  
The long‑term goal is to move to named accounts integrated with identity management and MFA.

### Hub-to-spoke connectivity

Hub and spoke VNets are connected using VNet peering:

- Hub → Spoke: allowed for required shared services and management flows  
- Spoke → Hub: restricted to necessary services only  
- Spoke → Spoke: not present in this phase  

---

## 5. Private endpoints and private DNS

The architecture implements private connectivity for key platform services:

- **Key Vault private endpoint** in the hub VNet  
- **Storage private endpoint(s)** where required for platform or logging services  
- **Private DNS zones** linked to the VNet to resolve private endpoint hostnames  

This ensures:

- Secrets and data are accessed over private IPs  
- No reliance on public DNS for platform service resolution from within the VNets  
- A realistic pattern that can be extended to additional services in future phases  

Private endpoints for additional services (e.g. App Service) can be added using the same pattern.

---

## 6. Monitoring and diagnostics

Network‑related monitoring is available and can be enabled as needed, including:

- NSG flow logs (v2) for selected NSGs  
- Diagnostic settings for supported network resources  
- Integration with Log Analytics when deployed  

These features provide visibility into network traffic and security posture.

See: `/docs/architecture/shared-services.md`

---

## 7. Administrative access pattern

Administrative access is designed around a controlled, identity‑centric flow:

1. **Jump‑ACI**  
   - Started via Azure CLI using authenticated credentials  
   - Provides a short‑lived, container‑based entry point  
   - Has no long‑lived presence or direct public inbound ports

2. **Jumphost VM**  
   - Resides in the hub network  
   - Acts as the primary interactive administration point  
   - Receives connections from Jump‑ACI  
   - Currently accessed using a generic account with shared keys

3. **Workload and platform resources**  
   - Accessed from the jumphost VM according to NSG rules  
   - Accessible only over private connectivity

Future enhancements will:

- Replace generic accounts with named user accounts  
- Integrate jumphost authentication with central identity and MFA  
- Further reduce reliance on static credentials or shared keys  

---

## 8. Extensibility

The network architecture is designed to scale.  
Future enhancements may include:

- Additional spokes for environment or workload separation  
- Azure Firewall or other NVAs for centralised egress control  
- Bastion for browser‑based access to VMs  
- VPN or ExpressRoute connectivity to on‑premises networks  
- More advanced routing (forced tunnelling, custom route tables)  
- Additional private endpoints and private DNS zones for other services  
- Multi‑region or zone‑redundant network designs  

The current implementation provides a realistic, secure foundation for these future capabilities.


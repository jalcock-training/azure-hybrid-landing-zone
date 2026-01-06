# Azure Hybrid Landing Zone – Architecture Overview (Phase 1 & Phase 2)

## 1. Executive Summary

The Azure Hybrid Landing Zone (AHLZ) is a modular, secure, private-endpoint-first cloud foundation designed to support hybrid workloads running across Azure and on-premises KVM infrastructure.

The architecture is intentionally split into two phases:

- Phase 1 – Free Tier / Basic (MVP)
  A fully functional, secure landing zone using only free-tier Azure capabilities. This phase is implemented today.

- Phase 2 – Paid Tier / Advanced (Roadmap)
  Enterprise-grade enhancements using paid SKUs such as Defender, Azure Firewall, JIT, and Sentinel.

The design emphasises:

- identity-driven access
- private-endpoint-only connectivity
- hybrid workload bootstrap via cloud-init
- modular Terraform structure
- clear governance boundaries
- minimal attack surface

This document provides the authoritative overview of the architecture, identity model, hybrid components, networking, governance, and deployment flow.

---

## 2. High-Level Architecture Overview

The landing zone is composed of the following layers:

- Platform: subscription-level configuration, identity, governance, shared services
- Networking: hub VNet, shared-services subnet, ACI jumpbox subnet, private-endpoints subnet
- Shared Services: Key Vault, Storage Account, private endpoints, DNS zones
- Hybrid Layer: Hybrid01 (SSH relay) and Hybrid02 (workload endpoint)
- Identity Layer: hybrid identity (AAD App + SP)
- Governance: policies, tagging, allowed locations, secure-by-default configuration
- Automation: Terraform modules, GitHub OIDC (Phase 2), state management

---

## 3. Phase 1 – Free Tier / Basic Architecture (MVP)

### 3.1 Core Platform
- Platform resource group
- Naming conventions and tagging standards
- Subscription-level tags
- Location restrictions
- Environment prefixes (planned)

### 3.2 Identity and Access
- Managed identities for platform and spokes
- Hybrid identity (AAD App + SP) for Hybrid02
- Least-privilege RBAC
- No classic administrators
- Terraform uses least-privilege roles
- Disable legacy auth (planned)

### 3.3 Networking
- Hub VNet
- Shared-services subnet
- ACI jumpbox subnet
- Private-endpoints subnet
- NSGs on all subnets
- Deny-all inbound rules
- VNet peering (hub ↔ spoke)
- Private endpoints for Key Vault and Storage

### 3.4 Private DNS
- Private DNS zone for Key Vault
- Private DNS zone for Storage (Blob and File)
- VNet links
- Dependency chains to avoid race conditions

### 3.5 Shared Services
- Key Vault (soft delete and purge protection)
- Storage Account (private endpoints)
- Public network access disabled
- TLS 1.2+ enforced

### 3.6 Compute
- ACI jumpbox (no public IP)
- Hybrid01 relay VM (no public IP)
- Hybrid02 workload VM (TLS bootstrap)
- SSH keys only

### 3.7 Diagnostics and Monitoring
- Activity Log export
- Metrics-only diagnostics for VNets and Storage

### 3.8 Governance and Policy
- Allowed locations policy
- Required tags policy
- Secure-by-default resource configuration
- Governance module separated from resource modules

### 3.9 Automation and CI/CD
- Terraform modules for all platform components
- Clean variable structure
- Feature toggles (governance, diagnostics, private endpoints)
- Clean state and repo hygiene

### 3.10 Documentation
- Architecture diagrams
- Module-level READMEs
- Security Hardening Checklist
- Architecture Implementation Checklist

---

## 4. Phase 2 – Paid Tier / Advanced Architecture (Roadmap)

### 4.1 Identity (Paid + Advanced Free Tier)
- Azure AD Privileged Identity Management (PIM)
- Remove unused service principals
- Remove stale accounts
- Hybrid identity rotation lifecycle
- Ephemeral ACI keypair for relay access

### 4.2 Networking (Paid + Advanced Free Tier)
- Azure Firewall (Standard/Premium)
- Just-In-Time VM Access (JIT)
- Outbound UDR deny-all + allowlist
- DNS forwarding ruleset (Private Resolver)
- Document SSH relay lateral movement boundaries

### 4.3 Data Protection (Paid + Advanced Free Tier)
- Defender for Storage malware scanning
- Soft delete on all Storage Accounts
- Disable public access on all Storage Accounts
- Infrastructure encryption
- Key Vault RBAC-only mode
- Backup/restore strategy for Key Vault and Storage

### 4.4 Compute (Paid + Advanced Free Tier)
- Defender for Servers
- Vulnerability Assessment for VMs
- VM extension minimisation
- VM diagnostic logs
- Harden hybrid01 package footprint
- Cloud-init secret-logging audit

### 4.5 Monitoring (Paid + Advanced Free Tier)
- NSG Flow Logs v2
- Defender for Cloud advanced threat detection
- Microsoft Sentinel
- Diagnostic settings for all resources
- Log Analytics workspace
- Alerts for Key Vault and Storage anomalies
- Basic metrics alerts

### 4.6 Governance (Paid + Advanced Free Tier)
- Microsoft Cloud Security Benchmark (MCSB)
- Allowed SKUs policies
- Diagnostic settings enforcement
- Private endpoint enforcement
- Tag enforcement
- Remediation tasks
- Regulatory compliance dashboards

### 4.7 Automation and CI/CD
- GitHub Actions pipeline with OIDC
- Automated policy compliance checks
- Drift detection

---

## 5. Identity Architecture

The identity layer is implemented in /platform/identity.

### Purpose
Provide a dedicated hybrid identity for workloads running outside Azure (Hybrid02).

### Components
- Azure AD Application
- Service Principal
- Client secret
- RBAC assignments to Key Vault and Storage
- Outputs consumed by Hybrid02 via remote state

### Rationale
- Keeps identity concerns separate from networking and shared services
- Ensures least-privilege access
- Enables hybrid workloads to authenticate securely without storing credentials in the VM image

### Why Hybrid01 does not use identity
Hybrid01 is an SSH relay only.  
It does not access Azure resources and therefore does not require identity.

---

## 6. Hybrid01 Architecture

### Purpose

Hybrid01 is a minimal VM that provides network connectivity from the Azure landing zone into the on-premises/libvirt network where Hybrid02 runs. It is not the primary operator access point; operator access flows through the jump ACI and jumphost VM.

### Key Characteristics

- No public IP
- No Azure identity
- Static IP (for example, 192.168.122.101 on the libvirt network)
- Configured to allow TCP forwarding into the libvirt network
- Minimal cloud-init configuration
- Deployed via the libvirt-hybrid-vm Terraform module

### Rationale

- Provides a simple, controlled network bridge into the libvirt environment
- Keeps operator access separated and managed via ACI and jumphost
- Allows you to demonstrate hybrid connectivity without exposing libvirt directly
- Keeps trust boundaries clear between Azure, the jumphost, and the on-premises hypervisor

---

## 7. Hybrid02 Architecture

### Purpose
A hybrid workload endpoint that retrieves TLS material from Azure and exposes a secure HTTPS endpoint.

### Key Characteristics
- Uses hybrid identity to authenticate to Azure
- Cloud-init bootstrap script performs:
  - az login using hybrid identity
  - Download cert and key from Key Vault
  - Download content from Storage
  - Configure nginx with TLS
- Static IP (192.168.122.102)
- Depends on hybrid02-prereqs for secret creation

### Rationale
- Demonstrates hybrid identity in action
- Shows secure bootstrap pattern
- Provides a real workload endpoint

---

## 8. Shared Services Architecture

### Components
- Key Vault
- Storage Account
- Private endpoints
- Private DNS zones

### Rationale
- Centralised secrets and content
- Private-endpoint-only access
- No public network exposure
- RBAC-controlled access for hybrid identity

---

## 9. Governance Architecture

### Phase 1
- Allowed locations
- Required tags
- Secure-by-default configuration
- Governance module separation

### Phase 2
- MCSB
- Allowed SKUs
- Diagnostic settings enforcement
- Private endpoint enforcement
- Tag enforcement
- Remediation tasks
- Compliance dashboards

---

## 10. Security Hardening Checklist (Phase-Aligned)

### Phase 1
- MFA
- Least-privilege RBAC
- No classic admins
- Private endpoints
- No public IPs
- NSGs + deny-all inbound
- Soft delete + purge protection
- TLS 1.2+
- Activity Log export

### Phase 2
- Defender suite
- Azure Firewall
- JIT
- Sentinel
- Diagnostic settings
- Alerts
- Enforcement policies
- Identity lifecycle

---

## 11. Architecture Implementation Checklist (Phase-Aligned)

### Phase 1
- Core platform
- Identity basics
- Networking
- Private DNS
- Shared services
- Hybrid01 and Hybrid02
- Basic diagnostics
- Governance basics
- Terraform automation

### Phase 2
- Advanced identity
- Advanced networking
- Advanced data protection
- Advanced compute
- Full diagnostics
- Full governance
- CI/CD automation

---

## 12. Access Patterns

### Operator Access

- Primary operator path:
  - Azure AD-authenticated access into jump ACI
  - SSH from jump ACI into the jumphost VM
  - From the jumphost, access to spoke workloads and, where required, to the hybrid connectivity path

### Hybrid Connectivity

- Hybrid01 provides network connectivity from the Azure side towards the libvirt network where Hybrid02 runs.
- Hybrid02 uses hybrid identity to pull secrets and content from Azure and exposes an HTTPS workload endpoint.
- No public ingress is exposed for either Hybrid01 or Hybrid02.

---

## 13. End-to-End Deployment Guide

### 13.1 Apply Order
1. /platform/hub             - operator workstation
2. /platform/shared-services - operator workstation
3. /platform/identity        - operator workstation
4. /spokes/spoke01           - hub jumphost
5. /hybrids/hybrid01         - operator workstation
6. /hybrids/hybrid02-prereqs - hub jumphost
7. /hybrids/hybrid02         - operator workstation

### 13.2 Hybrid02 Bootstrap Flow
1. Cloud-init installs Azure CLI
2. Logs in using hybrid identity
3. Downloads cert and key from Key Vault
4. Downloads content from Storage
5. Configures nginx with TLS
6. Starts HTTPS endpoint

### 13.3 Testing

1. Connect to the jump ACI container using Azure-native credentials.
2. From the ACI container, SSH to the jumphost VM in the hub VNet.
3. From the jumphost VM, use SSH or port forwarding to reach Hybrid02 (via the hybrid connectivity path).
4. Access the HTTPS endpoint exposed by Hybrid02.
5. Validate that the TLS certificate and content were retrieved from Key Vault and Storage.

### 13.4 Troubleshooting

- Check cloud-init logs on Hybrid02
- Check nginx logs on Hybrid02
- Validate hybrid identity permissions on Key Vault and Storage
- Validate private DNS resolution for Key Vault and Storage
- Validate NSG rules in hub, spokes, and shared-services subnets
- Validate network connectivity from Azure to the libvirt host and Hybrid01

---

## 14. Architecture Diagrams (Mermaid)

### 14.1 Platform Overview

```mermaid
flowchart TD
    A[Hub VNet] --> B[Shared Services Subnet]
    A --> C[ACI Jumpbox Subnet]
    A --> D[Private Endpoints Subnet]

    B --> E[Key Vault]
    B --> F[Storage Account]

    D --> E
    D --> F

### 14.2 Hybrid Flow

```mermaid
flowchart LR
    A[Hybrid01 - SSH Relay] --> B[Hybrid02 - Workload VM]
    B --> C[Azure Key Vault]
    B --> D[Azure Storage]

### 14.3 Identity Flow

```mermaid
flowchart LR
    A[Hybrid02] -->|az login| B[Hybrid Identity]
    B --> C[Key Vault RBAC]
    B --> D[Storage RBAC]


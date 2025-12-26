# Security Overview

This document describes the security posture of the Azure Hybrid Landing Zone
and outlines the controls, hardening measures, and governance patterns applied
across the environment. The design follows Azure security best practices and the
Microsoft Cloud Security Benchmark (MCSB), with a focus on secure‑by‑default
configuration, least privilege, and defence‑in‑depth.

Where relevant, features that require paid Defender for Cloud plans are noted
but not enabled, as this project is designed to operate on the Azure free tier.

---

## Identity & Access Management (IAM)

Identity is the primary security boundary in Azure. The environment applies the
following controls:

### Implemented (Free Tier)
- Multi‑factor authentication (MFA) enabled for all accounts.
- Least‑privilege RBAC assignments across all resources.
- No individual users assigned the **Owner** role.
- No classic administrators.
- Managed identities used for automation (e.g., jump‑ACI controlling the VM).
- Service principals use short‑lived OIDC tokens via GitHub Actions.
- Legacy authentication protocols disabled.

### Not Implemented (Paid Features)
- Privileged Identity Management (PIM)  
  *Requires Azure AD Premium P2.*

---

## Network Security

The network follows a hub‑and‑spoke architecture with strict segmentation and
no public access to administrative endpoints.

### Implemented (Free Tier)
- NSGs applied to all subnets with deny‑all inbound rules.
- No public IPs on VMs.
- Jump‑ACI pattern eliminates the need for public SSH/RDP.
- Private endpoints used for sensitive services (Key Vault, Storage).
- VNet peering configured with restricted traffic flow.
- Platform and workload separation via hub/spoke topology.

### Not Implemented (Paid Features)
- Just‑In‑Time VM Access (JIT)  
  *Requires Defender for Servers.*
- Azure Firewall Premium  
  *Paid service.*

---

## Data Protection & Storage Security

### Implemented (Free Tier)
- Encryption at rest enabled (default for all Azure services).
- Key Vault soft delete and purge protection enabled.
- Storage Account public access disabled.
- TLS 1.2 enforced.
- Private endpoints used for Key Vault and Storage.
- Infrastructure encryption enabled where supported.

### Not Implemented (Paid Features)
- Defender for Storage malware scanning.

---

## Compute Security

### Implemented (Free Tier)
- No public IPs on VMs.
- SSH key‑based authentication only.
- VM deallocated automatically when not in use (jump‑ACI lifecycle).
- Managed identity used for VM operations.
- Minimal VM extensions.
- Diagnostic settings enabled.

### Not Implemented (Paid Features)
- Defender for Servers (MDE agent, vulnerability scanning, JIT, FIM).
- VM vulnerability assessment.

---

## Logging, Monitoring & Diagnostics

### Implemented (Free Tier)
- Diagnostic settings enabled for:
  - Key Vault
  - Storage Accounts
  - NSGs (flow logs v2)
  - Activity Logs
  - VMs
- Logs sent to a Log Analytics workspace (free tier).
- Basic Azure Monitor alerts configured.

### Not Implemented (Paid Features)
- Advanced threat detection via Defender for Cloud.
- Microsoft Sentinel (SIEM).

---

## Governance & Policy

### Implemented (Free Tier)
- Microsoft Cloud Security Benchmark (MCSB) initiative assigned.
- Naming and tagging standards enforced.
- Resource location restrictions applied.
- Policies enforcing:
  - Private endpoints
  - Diagnostic settings
  - Network restrictions
- Non‑compliant resources remediated where possible.

### Not Implemented (Paid Features)
- Additional regulatory compliance dashboards (e.g., CIS, NIST).  
  *Requires Defender for Cloud.*

---

## Platform Hardening

### Implemented (Free Tier)
- Key Vault firewall enabled.
- Storage firewall enabled.
- Public network access disabled on PaaS services.
- Terraform state stored securely (local for portfolio; remote recommended for production).
- GitHub Actions uses OIDC for passwordless, short‑lived authentication.
- Jump‑ACI pattern reduces attack surface by removing public SSH.

### Not Implemented (Paid Features)
- Defender for Key Vault threat detection.
- Defender for App Service.

---

## Summary

This landing zone demonstrates a secure‑by‑default Azure architecture using
controls available on the free tier, while clearly identifying where paid
Defender for Cloud features would enhance security in an enterprise setting.

The environment incorporates:
- Strong identity controls  
- Network isolation  
- Private endpoints  
- Diagnostic logging  
- Governance via Azure Policy  
- Automated VM lifecycle management  
- No public administrative access  

These patterns reflect real‑world engineering practices and provide a solid
foundation for secure cloud operations.

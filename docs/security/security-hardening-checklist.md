# Azure Security Hardening Checklist  
Free‑Tier Friendly • Landing‑Zone Ready

This checklist tracks the security posture of your Azure Hybrid Landing Zone.  
Controls are grouped by domain, with free‑tier items prioritized and paid‑tier items clearly marked.

---

## Identity & Access Management (IAM)

Free‑tier controls:

- [ ] Enforce MFA for all accounts  
- [ ] Remove "Owner" role from individual users  
- [ ] Use least‑privilege RBAC everywhere  
- [ ] Remove unused or stale accounts  
- [ ] Disable legacy authentication (POP/IMAP/SMTP Basic)  
- [ ] Ensure no classic administrators are present  
- [ ] Use service principals or managed identities instead of shared secrets  
- [ ] Rotate credentials regularly  

Paid‑tier (not applicable on free plan):

- [ ] PIM (Privileged Identity Management)

---

## Network Security

Completed:

- [x] Apply NSGs to all subnets  
- [x] Deny‑all inbound rules by default  
- [x] No public IPs on VMs  
- [x] Use the jump‑ACI pattern instead of public SSH/RDP  
- [x] Ensure VNet peering is configured securely  
- [x] Add service endpoints for Key Vault and Storage  
- [x] Private DNS zones and VNet links for Key Vault and Storage  

Pending / Future:

- [ ] Use Private Endpoints for Key Vault  
- [ ] Use Private Endpoints for Storage  
- [ ] Disable public network access on PaaS services  
- [ ] Restrict outbound traffic where possible  

Paid‑tier:

- [ ] Just‑In‑Time VM Access (JIT)  
- [ ] Azure Firewall Premium  

---

## Data Protection & Storage Security

Completed:

- [x] Enable soft delete and purge protection on Key Vault  
- [x] Enforce TLS 1.2+ (policy added)  
- [x] Storage account deployed with secure defaults  
- [x] Private endpoints for Storage (Blob and File)  

Pending / Future:

- [ ] Enable soft delete on all Storage Accounts  
- [ ] Disable public access on Storage Accounts  
- [ ] Ensure encryption at rest is enabled (default)  
- [ ] Enable infrastructure encryption (optional, free)  
- [ ] Use private endpoints for all sensitive data services  

Paid‑tier:

- [ ] Defender for Storage malware scanning  

---

## Compute & VM Security

Completed:

- [x] Disable password authentication on Linux VMs  
- [x] Use SSH keys only  
- [x] Remove public IPs from VMs  
- [x] Use managed identities instead of local secrets  

Pending / Future:

- [ ] Ensure VM disks are encrypted (default, but verify)  
- [ ] Ensure VM extensions are minimal and necessary  
- [ ] Ensure diagnostic logs are enabled  

Paid‑tier:

- [ ] Defender for Servers  
- [ ] Vulnerability Assessment for VMs  

---

## Logging, Monitoring & Diagnostics

Completed:

- [x] Diagnostic settings module created  
- [x] Storage diagnostics corrected (metrics‑only)  
- [x] VNet diagnostics corrected (metrics‑only)  

Pending / Future:

- [ ] Enable diagnostic settings for Key Vault  
- [ ] Enable diagnostic settings for Storage Accounts (subresource logs if needed)  
- [ ] Enable diagnostic settings for VMs  
- [ ] Enable NSG Flow Logs v2  
- [ ] Enable Activity Log export  
- [ ] Send logs to a Log Analytics workspace  
- [ ] Enable Azure Monitor alerts for critical events  
- [ ] Configure basic metrics alerts (CPU, disk, network)  

Paid‑tier:

- [ ] Defender for Cloud advanced threat detection  
- [ ] Microsoft Sentinel  

---

## Governance & Policy

Completed:

- [x] Assign naming and tagging policies  
- [x] Assign resource location restrictions  
- [x] Assign policies to deny Key Vault public access  
- [x] Assign policies to deny Storage public access  
- [x] Assign policies to enforce TLS 1.2 on Storage  
- [x] Assign audit policy for diagnostic settings  
- [x] Add feature toggle for subscription‑level policies  
- [x] Clean separation between resource‑level security and governance  

Pending / Future:

- [ ] Assign the Microsoft Cloud Security Benchmark (MCSB) initiative  
- [ ] Assign allowed SKUs policies  
- [ ] Assign policies to enforce private endpoints  
- [ ] Assign policies to enforce diagnostic settings (mandatory, not audit)  
- [ ] Remediate non‑compliant resources  

Paid‑tier:

- [ ] Regulatory compliance dashboards beyond MCSB  

---

## Platform Hardening

Completed:

- [x] Use managed identities for automation  
- [x] Ensure Terraform state is stored securely (local is fine for portfolio)  
- [x] Ensure GitHub OIDC is used for CI/CD  
- [x] Add service endpoints to required subnets  
- [x] Fix storage account provisioning security posture  
- [x] Fix DNS link race conditions with explicit dependency chains  

Pending / Future:

- [ ] Ensure Key Vault firewall is enabled  
- [ ] Ensure Storage firewall is enabled  
- [ ] Disable public access on all PaaS services  

Paid‑tier:

- [ ] Defender for Key Vault  
- [ ] Defender for App Service  



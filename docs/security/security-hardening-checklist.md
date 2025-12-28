============================================================
        AZURE SECURITY HARDENING CHECKLIST (UPDATED)
============================================================

🔐 IDENTITY & ACCESS MANAGEMENT (IAM)
------------------------------------
[ ] Enforce MFA for all accounts
[ ] Remove “Owner” role from individual users
[ ] Use least‑privilege RBAC everywhere
[ ] Remove unused or stale accounts
[ ] Disable legacy authentication (POP/IMAP/SMTP Basic)
[ ] Ensure no classic administrators are present
[ ] Use service principals or managed identities instead of shared secrets
[ ] Rotate credentials regularly

Paid tier (not applicable):
[ ] ❌ Azure AD Privileged Identity Management (PIM)


🌐 NETWORK SECURITY
-------------------
✔ Completed
[x] Apply NSGs to all subnets
[x] Deny‑all inbound rules by default
[x] No public IPs on VMs
[x] Use jump‑ACI pattern instead of public SSH/RDP
[x] Ensure VNet peering is configured securely
[x] Create dedicated private-endpoints subnet
[x] Harden NSG rules for private-endpoints subnet
[x] Move Key Vault private endpoint into private-endpoints subnet
[x] Move Storage private endpoints into private-endpoints subnet
[x] Ensure NSG + UDR associations are correct and isolated

Pending / Future
[ ] Disable public network access on PaaS services
[ ] Restrict outbound traffic where possible (firewall or UDR strategy)
[ ] Add Azure Firewall (optional but recommended for enterprise posture)

Paid tier:
[ ] ❌ Just‑In‑Time VM Access (JIT)
[ ] ❌ Azure Firewall Premium


🔒 DATA PROTECTION & STORAGE SECURITY
------------------------------------
✔ Completed
[x] Enable soft delete + purge protection on Key Vault
[x] Enforce TLS 1.2+
[x] Use private endpoints for Key Vault
[x] Use private endpoints for Storage (Blob + File)

Pending / Future
[ ] Enable soft delete on all Storage Accounts
[ ] Disable public access on Storage Accounts
[ ] Ensure encryption at rest is enabled (default)
[ ] Enable infrastructure encryption (optional)

Paid tier:
[ ] ❌ Defender for Storage malware scanning


🧱 COMPUTE & VM SECURITY
------------------------
✔ Completed
[x] Disable password authentication on Linux VMs
[x] Use SSH keys only
[x] Remove public IPs from VMs
[x] Use managed identities instead of local secrets

Pending / Future
[ ] Ensure VM disks are encrypted (default, verify)
[ ] Ensure VM extensions are minimal and necessary
[ ] Ensure diagnostic logs are enabled

Paid tier:
[ ] ❌ Defender for Servers
[ ] ❌ Vulnerability Assessment for VMs


📊 LOGGING, MONITORING & DIAGNOSTICS
------------------------------------
Pending / Future
[ ] Enable diagnostic settings for Key Vault
[ ] Enable diagnostic settings for Storage Accounts
[ ] Enable diagnostic settings for VMs
[ ] Enable NSG Flow Logs v2 (optional, subscription‑dependent)
[ ] Enable Activity Log export
[ ] Send logs to Log Analytics workspace
[ ] Enable Azure Monitor alerts for critical events
[ ] Configure basic metrics alerts (CPU, disk, network)

Paid tier:
[ ] ❌ Defender for Cloud advanced threat detection
[ ] ❌ Microsoft Sentinel


🛡 GOVERNANCE & POLICY
----------------------
✔ Completed
[x] Assign naming and tagging policies
[x] Assign resource location restrictions
[x] Deny Key Vault public access
[x] Deny Storage public access
[x] Enforce TLS 1.2 on Storage
[x] Audit policy for diagnostic settings
[x] Enforce private endpoints on Key Vault + Storage (via architecture)

Pending / Future
[ ] Assign Microsoft Cloud Security Benchmark (MCSB)
[ ] Assign allowed SKUs policies
[ ] Enforce diagnostic settings (mandatory)
[ ] Remediate non‑compliant resources

Paid tier:
[ ] ❌ Regulatory compliance dashboards beyond MCSB


🧩 PLATFORM HARDENING
---------------------
✔ Completed
[x] Use managed identities for automation
[x] Ensure Terraform state is stored securely
[x] Use GitHub OIDC for CI/CD
[x] Implement dedicated private-endpoints subnet
[x] Harden NSGs and route tables for isolation

Pending / Future
[ ] Enable Key Vault firewall
[ ] Enable Storage firewall
[ ] Disable public access on all PaaS services

Paid tier:
[ ] ❌ Defender for Key Vault
[ ] ❌ Defender for App Service

============================================================


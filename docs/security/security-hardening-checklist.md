============================================================
              AZURE SECURITY HARDENING CHECKLIST
============================================================

This checklist reflects the current security posture of the Azure Hybrid Landing Zone, including platform, shared services, and hybrid workloads. Items are grouped into **Completed**, **Pending/Future**, and **Paid Tier (Out of Scope)** to clearly communicate maturity and roadmap.

---

# 🔐 IDENTITY & ACCESS MANAGEMENT (IAM)

## ✅ Completed
- [x] MFA enforced for all operators (IdP-level)
- [x] Least‑privilege RBAC applied across all scopes
- [x] No classic administrators present
- [x] Managed identities used for platform and spokes
- [x] Hybrid workloads use dedicated hybrid identity (AAD App + SP)
- [x] No shared secrets except hybrid identity (documented and controlled)

## ⏳ Pending / Future
- [ ] Remove “Owner” role from individual users (tenant hardening)
- [ ] Remove unused or stale accounts (AAD hygiene)
- [ ] Disable legacy authentication (POP/IMAP/SMTP Basic)
- [ ] Replace jumphost generic SSH key with ephemeral ACI‑delivered keypair
- [ ] Document hybrid identity secret rotation procedure
- [ ] Review and remove unused service principals

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Azure AD Privileged Identity Management (PIM)

---

# 🌐 NETWORK SECURITY

## ✅ Completed
- [x] NSGs applied to all subnets
- [x] Deny‑all inbound rules by default
- [x] No public IPs on any VMs
- [x] Jump‑ACI pattern used instead of public SSH/RDP
- [x] Secure VNet peering (no transitive routing)
- [x] Dedicated private-endpoints subnet
- [x] Hardened NSG rules for private-endpoints subnet
- [x] Key Vault private endpoint isolated in private-endpoints subnet
- [x] Storage private endpoints isolated in private-endpoints subnet
- [x] NSG + UDR associations validated
- [x] Public network access disabled on Key Vault
- [x] Public network access disabled on Storage

## ⏳ Pending / Future
- [ ] Disable public network access on App Service (if introduced)
- [ ] Restrict outbound traffic using UDRs (deny-all + allowlist)
- [ ] Validate DNS resolution paths for private endpoints (hub → hybrid01 → hybrid02)
- [ ] Document SSH relay architecture and lateral movement boundaries

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Azure Firewall (Standard/Premium)
- [ ] ❌ Just‑In‑Time VM Access (JIT)
- [ ] ❌ Azure Firewall Premium

---

# 🔒 DATA PROTECTION & STORAGE SECURITY

## ✅ Completed
- [x] Soft delete + purge protection enabled on Key Vault
- [x] TLS 1.2+ enforced
- [x] Private endpoints for Key Vault
- [x] Private endpoints for Storage (Blob + File)
- [x] Encryption at rest enabled (default)

## ⏳ Pending / Future
- [ ] Enable soft delete on all Storage Accounts (verify)
- [ ] Disable public access on all Storage Accounts (verify)
- [ ] Enable infrastructure encryption (optional)
- [ ] Enable Key Vault RBAC‑only mode (if not already)
- [ ] Document backup/restore strategy for Key Vault + Storage

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Defender for Storage malware scanning

---

# 🧱 COMPUTE & VM SECURITY

## ✅ Completed
- [x] Password authentication disabled on Linux VMs
- [x] SSH keys only
- [x] No public IPs on any VMs
- [x] Managed identities used for platform workloads
- [x] VM disks encrypted (default)
- [x] Hybrid02 TLS key permissions hardened (600)

## ⏳ Pending / Future
- [ ] Ensure VM extensions are minimal and necessary
- [ ] Enable diagnostic logs for VMs
- [ ] Validate cloud-init scripts do not log secrets
- [ ] Harden hybrid01 (relay) package footprint

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Defender for Servers
- [ ] ❌ Vulnerability Assessment for VMs

---

# 📊 LOGGING, MONITORING & DIAGNOSTICS

## ✅ Completed
- [x] Activity Log export enabled

## ⏳ Pending / Future
- [ ] Enable diagnostic settings for Key Vault (AuditEvent)
- [ ] Enable diagnostic settings for Storage Accounts (BlobRead/Write/Delete)
- [ ] Enable diagnostic settings for VMs
- [ ] Enable diagnostic settings for NSGs, VNets, and private endpoints
- [ ] Create Log Analytics workspace (free tier acceptable)
- [ ] Route all diagnostic logs to workspace
- [ ] Add alert for Key Vault secret access from unexpected identity
- [ ] Add alert for Storage access from unexpected identity
- [ ] Add basic metrics alerts (CPU, disk, network)

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ NSG Flow Logs v2
- [ ] ❌ Defender for Cloud advanced threat detection
- [ ] ❌ Microsoft Sentinel

---

# 🛡 GOVERNANCE & POLICY

## ✅ Completed
- [x] Naming and tagging policies assigned
- [x] Resource location restrictions applied
- [x] Deny Key Vault public access policy
- [x] Deny Storage public access policy
- [x] Enforce TLS 1.2 on Storage
- [x] Audit policy for diagnostic settings
- [x] Enforce private endpoints for Key Vault + Storage (architecture)

## ⏳ Pending / Future
- [ ] Assign Microsoft Cloud Security Benchmark (MCSB)
- [ ] Assign allowed SKUs policies
- [ ] Enforce diagnostic settings (mandatory)
- [ ] Remediate non‑compliant resources
- [ ] Enforce “Deny public IP” policy for compute
- [ ] Enforce “Require private endpoints” for PaaS services
- [ ] Enforce tag requirements (owner, environment, costcenter)

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Regulatory compliance dashboards beyond MCSB

---

# 🧩 PLATFORM HARDENING

## ✅ Completed
- [x] Managed identities used for automation
- [x] Terraform state stored securely (Storage + RBAC)
- [x] GitHub OIDC used for CI/CD
- [x] Dedicated private-endpoints subnet
- [x] Hardened NSGs and route tables for isolation

## ⏳ Pending / Future
- [ ] Enable Key Vault firewall (beyond private endpoint)
- [ ] Enable Storage firewall (beyond private endpoint)
- [ ] Disable public access on App Service (if introduced)
- [ ] Document hybrid identity lifecycle (creation, rotation, deletion)
- [ ] Document SSH relay lifecycle (keys, rotation, access)
- [ ] Document Terraform state recovery procedure
- [ ] Validate hub → hybrid01 → hybrid02 trust boundaries

## 💰 Paid Tier (Out of Scope)
- [ ] ❌ Defender for Key Vault
- [ ] ❌ Defender for App Service

============================================================


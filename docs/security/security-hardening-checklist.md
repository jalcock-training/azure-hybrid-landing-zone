============================================================
        SECURITY HARDENING CHECKLIST – TWO‑PHASE MODEL
============================================================

This checklist aligns security controls with the two‑phase landing zone architecture:

- **Phase 1 – Free Tier / Basic Security (Current Project)**
- **Phase 2 – Paid Tier / Advanced Security (Future Roadmap)**

---

# 🟦 PHASE 1 — FREE TIER / BASIC SECURITY (MVP)

## 🔐 Identity & Access Management (IAM)

### ✅ Completed
- [x] MFA enforced for operators  
- [x] Least‑privilege RBAC  
- [x] No classic administrators  
- [x] Managed identities for platform + spokes  
- [x] Hybrid identity (AAD App + SP) for hybrid workloads  
- [x] Terraform uses least‑privilege roles  

### ⏳ Minimal Free‑Tier Additions
- [ ] Disable legacy authentication (POP/IMAP/SMTP Basic)  

---

## 🌐 Network Security

### ✅ Completed
- [x] NSGs on all subnets  
- [x] Deny‑all inbound rules  
- [x] No public IPs on VMs  
- [x] Jump‑ACI pattern instead of public SSH/RDP  
- [x] Private‑endpoint‑only access for Key Vault + Storage  
- [x] Hardened private‑endpoint subnet  
- [x] VNet peering (hub ↔ spoke)  

---

## 🔒 Data Protection & Storage Security

### ✅ Completed
- [x] Soft delete + purge protection on Key Vault  
- [x] TLS 1.2+ enforced  
- [x] Private endpoints for Key Vault + Storage  
- [x] Encryption at rest enabled  

---

## 🧱 Compute & VM Security

### ✅ Completed
- [x] SSH keys only  
- [x] Password auth disabled  
- [x] No public IPs  
- [x] VM disks encrypted  
- [x] Hybrid02 TLS key permissions hardened  

---

## 📊 Logging, Monitoring & Diagnostics

### ✅ Completed
- [x] Activity Log export  

---

## 🛡 Governance & Policy

### ✅ Completed
- [x] Allowed locations policy  
- [x] Required tags policy  
- [x] Deny public access for Key Vault + Storage  
- [x] Secure‑by‑default resource configuration  

---

## 🧩 Platform Hardening

### ✅ Completed
- [x] Terraform state secured (RBAC + private access)  
- [x] Private‑endpoints subnet  
- [x] Hardened NSGs + route tables  

============================================================

# 🟥 PHASE 2 — PAID TIER / ADVANCED SECURITY (ROADMAP)

## 🔐 Identity (Paid + Advanced Free Tier)
- [ ] Azure AD Privileged Identity Management (PIM)  
- [ ] Remove “Owner” role from individual users  
- [ ] Remove stale accounts  
- [ ] Review/remove unused service principals  
- [ ] Document hybrid identity rotation  
- [ ] Replace jumphost generic SSH key with ephemeral ACI keypair  

---

## 🌐 Network Security (Paid + Advanced Free Tier)
- [ ] Azure Firewall (Standard/Premium)  
- [ ] Just‑In‑Time VM Access (JIT)  
- [ ] Outbound UDR deny‑all + allowlist  
- [ ] DNS forwarding ruleset (Private Resolver)  
- [ ] Validate DNS resolution paths end‑to‑end  
- [ ] Document SSH relay lateral movement boundaries  

---

## 🔒 Data Protection (Paid + Advanced Free Tier)
- [ ] Defender for Storage malware scanning  
- [ ] Enable soft delete on all Storage Accounts  
- [ ] Disable public access on all Storage Accounts  
- [ ] Infrastructure encryption  
- [ ] Key Vault RBAC‑only mode  
- [ ] Backup/restore strategy for KV + Storage  

---

## 🧱 Compute & VM Security (Paid + Advanced Free Tier)
- [ ] Defender for Servers  
- [ ] Vulnerability Assessment for VMs  
- [ ] VM extension minimisation  
- [ ] VM diagnostic logs  
- [ ] Harden hybrid01 package footprint  
- [ ] Cloud‑init secret‑logging audit  

---

## 📊 Monitoring (Paid + Advanced Free Tier)
- [ ] NSG Flow Logs v2  
- [ ] Defender for Cloud advanced threat detection  
- [ ] Microsoft Sentinel  
- [ ] Diagnostic settings for Key Vault  
- [ ] Diagnostic settings for Storage  
- [ ] Diagnostic settings for VMs  
- [ ] Diagnostic settings for NSGs, VNets, private endpoints  
- [ ] Log Analytics workspace  
- [ ] Alerts for KV/Storage access anomalies  
- [ ] Basic metrics alerts (CPU, disk, network)  

---

## 🛡 Governance (Paid + Advanced Free Tier)
- [ ] Microsoft Cloud Security Benchmark (MCSB)  
- [ ] Allowed SKUs policies  
- [ ] Diagnostic settings enforcement  
- [ ] Private endpoint enforcement  
- [ ] Tag enforcement (owner, environment, costcenter)  
- [ ] Remediation tasks  
- [ ] Regulatory compliance dashboards  

---

## 🧩 Platform Hardening (Advanced Free Tier)
- [ ] Key Vault firewall  
- [ ] Storage firewall  
- [ ] Hybrid identity lifecycle documentation  
- [ ] SSH relay lifecycle documentation  
- [ ] Terraform state recovery procedure  
- [ ] Validate hub → hybrid01 → hybrid02 trust boundaries  

---

============================================================


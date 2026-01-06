============================================================
        AZURE HYBRID LANDING ZONE – TWO‑PHASE ARCHITECTURE
============================================================

This document splits the Azure Hybrid Landing Zone into:

- **Phase 1 – Free Tier / Basic Architecture (Current Project)**
- **Phase 2 – Paid Tier / Advanced Architecture (Future Roadmap)**

Phase 1 includes the basic structure and free tier enhancements.  
Phase 2 contains enterprise‑grade enhancements requiring paid SKUs or deeper engineering.

---

# 🟦 PHASE 1 — FREE TIER / BASIC 

## 🧱 Core Platform
- [x] Platform resource group
- [x] Naming conventions + tagging standards
- [x] Subscription‑level tags
- [x] Location restrictions
- [ ] Add environment prefixes (dev/test/prod) 

---

## 🔐 Identity & Access
- [x] Managed identities for platform + spokes
- [x] Hybrid identity (AAD App + SP) for hybrid workloads
- [x] Least‑privilege RBAC everywhere
- [x] No classic administrators
- [x] Terraform uses least‑privilege roles
- [ ] Remove unused service principals 
- [ ] Disable legacy auth (POP/IMAP/SMTP Basic) 

---

## 🌐 Networking
- [x] Hub VNet
- [x] Shared‑services subnet
- [x] ACI jumpbox subnet
- [x] Private‑endpoints subnet
- [x] NSGs on all subnets
- [x] Deny‑all inbound rules
- [x] VNet peering (hub ↔ spoke)
- [x] Private endpoints for Key Vault + Storage
- [ ] Add outbound UDRs (deny‑all + allowlist) 

---

## 🧭 Private DNS
- [x] Private DNS zone for Key Vault
- [x] Private DNS zone for Storage (Blob)
- [x] Private DNS zone for Storage (File)
- [x] VNet links
- [x] Dependency chains to avoid race conditions

---

## 🛠 Shared Services
- [x] Key Vault (soft delete + purge protection)
- [x] Storage Account (private endpoints)
- [x] Public network access disabled
- [x] TLS 1.2+ enforced
- [ ] Add Log Analytics workspace 

---

## 🖥 Compute
- [x] ACI jumpbox (no public IP)
- [x] SSH keys only
- [x] Hybrid01 relay VM (no public IP)
- [x] Hybrid02 workload VM (TLS bootstrap)
- [ ] Harden hybrid01 package footprint 

---

## 📊 Diagnostics & Monitoring
- [x] Activity Log export
- [x] Metrics‑only diagnostics for VNets + Storage
- [ ] Diagnostic settings for Key Vault 
- [ ] Diagnostic settings for VMs 
- [ ] Basic alert rules (CPU, disk, network) 

---

## 🛡 Governance & Policy
- [x] Allowed locations policy
- [x] Required tags policy
- [x] Secure‑by‑default resource configuration
- [x] Governance module separated from resource modules
- [ ] Assign allowed SKUs policies 
- [ ] Assign diagnostic settings enforcement 

---

## 🤖 Automation & CI/CD
- [x] Terraform modules for all platform components
- [x] Clean variable structure
- [x] Feature toggles (governance, diagnostics, private endpoints)
- [x] Clean state + repo hygiene
- [ ] GitHub Actions pipeline with OIDC 

---

## 📚 Documentation
- [x] Architecture diagrams
- [x] Module‑level READMEs
- [x] Security Hardening Checklist
- [x] Architecture Implementation Checklist
- [ ] End‑to‑end deployment guide *(low effort)*
- [ ] Troubleshooting guide *(low effort)*

---

# 🟩 PHASE 1 SUMMARY
Phase 1 is **fully deployable today**, secure, private‑endpoint‑first, and entirely free‑tier.  
It demonstrates:

- hybrid connectivity  
- secure workload bootstrap  
- private endpoints  
- identity‑driven access  
- clean Terraform architecture  
- strong governance  

---

# 🟥 PHASE 2 — PAID TIER / ADVANCED (ENTERPRISE ROADMAP)

## 🔐 Identity (Paid)
- [ ] Azure AD Privileged Identity Management (PIM)

---

## 🌐 Networking (Paid)
- [ ] Azure Firewall (Standard/Premium)
- [ ] Just‑In‑Time VM Access (JIT)

---

## 🔒 Data Protection 
- [ ] Defender for Storage malware scanning

---

## 🧱 Compute 
- [ ] Defender for Servers
- [ ] Vulnerability Assessment for VMs

---

## 📊 Monitoring 
- [ ] NSG Flow Logs v2
- [ ] Defender for Cloud advanced threat detection
- [ ] Microsoft Sentinel

---

## 🤖 Automation & CI/CD
- [ ] GitHub Actions pipeline with OIDC 

## 🛡 Governance 
- [ ] Regulatory compliance dashboards beyond MCSB

---

# 🟥 PHASE 2 SUMMARY
Phase 2 adds enterprise‑grade capabilities:

- advanced threat detection  
- firewalling  
- JIT access  
- regulatory dashboards  
- full Defender suite  

These are optional and require paid SKUs.

---


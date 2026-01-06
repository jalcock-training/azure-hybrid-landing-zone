============================================================
        AZURE HYBRID LANDING ZONE – TWO‑PHASE ARCHITECTURE
============================================================

This document splits the Azure Hybrid Landing Zone into:

- **Phase 1 – Free Tier / Basic Architecture (Current Project)**
- **Phase 2 – Paid Tier / Advanced Architecture (Future Roadmap)**

Phase 1 contains only the implemented MVP and a few essential free‑tier items.  
Phase 2 contains all advanced, enterprise‑grade, or paid‑tier enhancements.

---

# 🟦 PHASE 1 — FREE TIER / BASIC (MVP)

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

---

## 🖥 Compute
- [x] ACI jumpbox (no public IP)
- [x] SSH keys only
- [x] Hybrid01 relay VM (no public IP)
- [x] Hybrid02 workload VM (TLS bootstrap)

---

## 📊 Diagnostics & Monitoring
- [x] Activity Log export
- [x] Metrics‑only diagnostics for VNets + Storage

---

## 🛡 Governance & Policy
- [x] Allowed locations policy
- [x] Required tags policy
- [x] Secure‑by‑default resource configuration
- [x] Governance module separated from resource modules

---

## 🤖 Automation & CI/CD
- [x] Terraform modules for all platform components
- [x] Clean variable structure
- [x] Feature toggles (governance, diagnostics, private endpoints)
- [x] Clean state + repo hygiene

---

## 📚 Documentation
- [x] Architecture diagrams
- [x] Module‑level READMEs
- [x] Security Hardening Checklist
- [x] Architecture Implementation Checklist
- [ ] End‑to‑end deployment guide 
- [ ] Troubleshooting guide

---

# 🟩 PHASE 1 SUMMARY
Phase 1 is a **fully deployable, secure, free‑tier landing zone** featuring:

- private‑endpoint‑first architecture  
- hybrid workload bootstrap  
- hardened networking  
- identity‑driven access  
- secure Terraform state  
- foundational governance  

This is the MVP and the core of the project.

---

# 🟥 PHASE 2 — PAID TIER / ADVANCED (ENTERPRISE ROADMAP)

## 🔐 Identity (Paid + Advanced Free Tier)
- [ ] Azure AD Privileged Identity Management (PIM)
- [ ] Remove unused service principals
- [ ] Remove stale accounts
- [ ] Review/remove unused service principals
- [ ] Document hybrid identity rotation
- [ ] Replace jumphost generic SSH key with ephemeral ACI keypair

---

## 🌐 Networking (Paid + Advanced Free Tier)
- [ ] Azure Firewall (Standard/Premium)
- [ ] Just‑In‑Time VM Access (JIT)
- [ ] Add outbound UDRs (deny‑all + allowlist)
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

## 🧱 Compute (Paid + Advanced Free Tier)
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

## 🤖 Automation & CI/CD (Paid + Advanced Free Tier)
- [ ] GitHub Actions pipeline with OIDC
- [ ] Automated policy compliance checks
- [ ] Drift detection

---

# 🟥 PHASE 2 SUMMARY
Phase 2 introduces enterprise‑grade capabilities:

- advanced threat detection  
- firewalling and JIT access  
- full Defender suite  
- deep diagnostics and monitoring  
- compliance automation  
- operational hardening  

These enhancements require paid SKUs or additional engineering effort.

============================================================


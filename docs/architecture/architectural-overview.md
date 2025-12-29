# Architectural Overview

This document provides a high‑level overview of the Azure Hybrid Landing Zone architecture.  
It describes the core components, how they interact, and the principles that guide the design.  
The architecture is intentionally minimal, cost‑efficient, and aligned with Azure landing zone best practices.

For detailed information on specific areas, see:
- `/docs/architecture/landing-zone-design.md`
- `/docs/architecture/hub-and-spoke-network.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/architecture/shared-services.md`
- `/docs/architecture/hybrid-architecture.md`
- `/docs/security/security-overview.md`
- `/docs/reference/terraform-structure.md`

---

## 1. Purpose of the Architecture

The Azure Hybrid Landing Zone demonstrates how a small, cost‑efficient environment can implement enterprise‑aligned patterns across:

- Governance  
- Networking  
- Security  
- Shared services  
- Hybrid/on‑premises integration  
- Automation and CI/CD  

The design focuses on clarity and secure‑by‑default principles while remaining simple enough to run entirely within free‑tier or low‑cost Azure services.

---

## 2. High‑Level Components

The architecture consists of the following major components:

### **Landing Zone (Control Plane)**
A subscription‑scoped landing zone providing:

- Identity and access control  
- Policy‑driven governance  
- Standardised tagging and naming  
- Secure‑by‑default configuration baselines  

See: `/docs/architecture/landing-zone-design.md`

---

### **Hub-and-Spoke Network**
A minimal network topology that provides:

- A central hub VNet for shared services  
- A spoke VNet for workload isolation  
- NSGs enforcing deny‑all inbound rules  
- Private endpoints for platform services (when enabled)

See: `/docs/architecture/hub-and-spoke-network.md`

---

### **Shared Services**
Centralised platform services used across the environment, including:

- Azure Key Vault  
- Optional Log Analytics workspace  
- Diagnostic settings (when enabled)

These services provide secure secret management, monitoring, and operational consistency.

See: `/docs/architecture/shared-services.md`

---

### **Hybrid Integration (Azure Arc)**
A lightweight on‑premises Linux VM is onboarded using Azure Arc to demonstrate:

- Inventory and metadata visibility in Azure  
- Policy‑driven governance  
- Optional monitoring  
- Consistent operational practices across cloud and hybrid resources  

See: `/docs/architecture/hybrid-architecture.md`

---

### **Application Workload**
A simple web workload deployed into the spoke network using:

- App Service (with private access when enabled)  
- Storage account for application data  
- Managed identities for secure access  

This demonstrates secure workload deployment patterns.

See: `/docs/architecture/application-workload.md`

---

### **Automation and CI/CD**
A GitHub Actions pipeline deploys the entire environment using:

- Terraform  
- OIDC‑based authentication  
- Manual approval for apply  
- Secure, repeatable workflows  

See: `/docs/architecture/automation-and-ci-cd.md`

---

## 3. Security-by-Design

Security is embedded throughout the architecture using:

- Least‑privilege RBAC  
- No public IPs on compute resources  
- Private endpoints for platform services (when enabled)  
- NSGs enforcing deny‑all inbound rules  
- Policy‑driven configuration baselines  
- Identity‑based access for automation  

Full details: `/docs/security/security-overview.md`

---

## 4. Governance and Policy

Governance is applied at the subscription level and includes:

- Required tagging  
- Allowed locations  
- Baseline security policies  
- Optional diagnostic settings  
- Policy‑driven prevention of public IPs  

Full details: `/docs/architecture/governance-and-policy.md`

---

## 5. Extensibility

The architecture is intentionally minimal but designed to scale.  
Future enhancements may include:

- Additional spokes and workloads  
- Private DNS zones  
- Azure Firewall or Bastion  
- Defender for Cloud integration  
- Management‑group hierarchy  
- Multi‑subscription landing zone  
- Advanced guest configuration for Arc resources  

These enhancements can be added without redesigning the core architecture.

---

## 6. Summary

The Azure Hybrid Landing Zone provides a clean, secure, and extensible foundation that demonstrates:

- Enterprise‑aligned governance  
- Secure‑by‑default networking  
- Centralised shared services  
- Hybrid/on‑premises integration  
- Modern automation practices  

It balances simplicity with architectural clarity, making it suitable for learning, demonstration, and future expansion.


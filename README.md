# Azure Hybrid Landing Zone (Portfolio Project)

This repository contains a complete, minimal, and cost‑efficient Azure Hybrid Landing Zone designed as a portfolio project to demonstrate cloud architecture, governance, automation, and hybrid integration using Azure Arc. The environment follows Azure landing zone principles while remaining lightweight enough for personal use.

The project showcases practical, real‑world engineering skills across architecture, Terraform, CI/CD, governance, and hybrid cloud operations.

---

## Project Overview

This project implements a fully documented hybrid cloud environment that includes:

- A lightweight Azure landing zone with governance and management groups  
- Hub‑and‑spoke network architecture  
- Shared services such as Log Analytics and Key Vault  
- A simple application workload deployed into the spoke  
- Hybrid integration using Azure Arc for an on‑premises Linux VM  
- Terraform‑based infrastructure‑as‑code  
- GitHub Actions CI/CD pipeline using secure OIDC authentication  
- Clear, professional documentation suitable for portfolio presentation  

The design emphasises clarity, governance, and automation over complexity.

---

## Repository Structure

.
├── docs/
│   ├── architecture/
│   │   ├── architectural-overview.md
│   │   ├── landing-zone-design.md
│   │   ├── hub-and-spoke-network.md
│   │   ├── hybrid-architecture.md
│   │   ├── shared-services.md
│   │   ├── automation-and-ci-cd.md
│   │   └── application-workload.md
│   │
│   ├── planning/
│   │   └── project-plan.md
│   │
│   └── reference/
│       ├── terraform-structure.md
│       └── naming-and-tagging-standards.md
│
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── providers.tf
    └── modules/
        ├── landing-zone/
        ├── hub-network/
        ├── spoke-network/
        ├── shared-services/
        ├── application-workload/
        └── arc-onboarding/


This structure mirrors real enterprise engineering repositories and keeps architecture, planning, and implementation cleanly separated.

---

## Key Features

### **Hybrid Cloud Integration**
A local Linux VM is onboarded into Azure using Azure Arc, demonstrating governance, monitoring, and configuration management for non‑Azure resources.

### **Landing Zone Architecture**
A minimal but realistic landing zone with management groups, policy, RBAC, and subscription separation.

### **Hub‑and‑Spoke Networking**
A clean network topology with a platform hub and workload spoke, connected via VNet peering.

### **Shared Services**
Centralised Log Analytics workspace, Key Vault, and diagnostic settings.

### **Application Workload**
A simple App Service + Storage workload deployed into the spoke network.

### **Terraform IaC**
Modular Terraform structure aligned with the architecture documents.

### **GitHub Actions CI/CD**
Secure, automated deployment pipeline using OIDC authentication and manual approvals.

---

## Documentation

All documentation is located in the `docs/` folder and is grouped into:

- **Architecture** — design documents explaining the environment  
- **Planning** — project plan and delivery structure  
- **Reference** — implementation details such as naming standards and Terraform layout  

Start with:

`docs/architecture/architectural-overview.md`

---

## Prerequisites

To deploy or work with this project, you will need:

- Azure subscription  
- Azure CLI  
- Terraform  
- GitHub account (for CI/CD)  
- Local virtualisation platform (e.g., KVM) for the Azure Arc demo VM  

---

## Deployment

Deployment is performed through:

- Terraform (root module)  
- GitHub Actions CI/CD pipeline  

The pipeline handles:

- Formatting and validation  
- Planning  
- Manual approval  
- Apply  

Authentication uses secure, short‑lived OIDC tokens.

---

## Future Enhancements

Potential future improvements include:

- Additional spokes (dev/test/prod)  
- Private DNS zones  
- Defender for Cloud integration  
- Azure Firewall or third‑party NVAs  
- Arc‑enabled Kubernetes or SQL Server  
- Multi‑region expansion  

---

## Purpose of This Project

This project is designed as a **portfolio‑ready demonstration** of:

- Cloud architecture  
- Hybrid cloud integration  
- Infrastructure‑as‑code  
- DevOps automation  
- Governance and policy  
- Documentation quality  

It reflects real‑world engineering patterns while remaining accessible and cost‑efficient.

---

## License

See the LICENSE file in the root of this project


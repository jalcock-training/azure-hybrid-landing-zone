# Azure Hybrid Landing Zone

A full Azure landing zone engineered from scratch using 100% Terraform. Includes modular IaC design, hub/spoke topology, Azure AD/RBAC integration, policy automation, diagnostics, and secure baseline governance. This project reflects the same patterns used in enterprise landing zones, implemented independently to deepen my cloud engineering capability

## Key Features

### Landing Zone Architecture
A minimal but realistic landing zone with:

- Subscription‑scoped governance (policy, RBAC, naming/tagging)
- Hub‑and‑spoke networking
- Shared services (Key Vault, Storage)
- Private DNS
- Diagnostics and logging

### Hub‑and‑Spoke Networking
A clean network topology with:

- Hub VNet (platform)
- Spoke VNet (workload)
- VNet peering
- NSGs with deny‑all inbound
- No public IPs

### Shared Services
- Key Vault (private endpoint, RBAC‑only, soft delete, purge protection)
- Storage Account (private endpoint, TLS 1.2+, no public access)
- Optional Log Analytics workspace

### Application Workloads
Two workload patterns are demonstrated:

- **Azure workload** deployed into the spoke using the workload‑vm module
- **Hybrid workload** (Hybrid02) running on libvirt and bootstrapped via cloud‑init

### Hybrid Connectivity (libvirt/KVM)
A realistic hybrid pattern using:

- Hybrid01 for network bridging
- Hybrid02 for workload execution
- Hybrid identity for secure bootstrap
- Private‑endpoint‑only access to Azure services

### Terraform IaC
- Modular Terraform structure aligned with the architecture
- Clear separation of platform, spokes, and hybrid layers
- Remote state
- Feature toggles for diagnostics, governance, and private endpoints

### Optional GitHub Actions CI/CD
- Secure OIDC authentication
- No long‑lived credentials
- Plan → approval → apply workflow

---

## Jump Environment Workflow

The landing zone includes an ephemeral jump environment built using Azure Container Instances (ACI). This provides a lightweight, cost‑efficient way to access the jumphost VM.

Workflow:

1. Start the jump‑ACI using `./scripts/jump-start.sh`
2. Exec into the container and SSH to the jumphost VM
3. While SSH is active, the container remains running
4. When SSH exits, the container becomes idle
5. After the idle timeout, the container exits
6. Cleanup logic deallocates the jumphost VM

This ensures the environment remains cost‑efficient and predictable.

---

## Documentation

All documentation is located in the `docs/` folder and is grouped into:

- **Architecture** — design documents explaining the environment  
- **Planning** — project plan and delivery structure  
- **Reference** — naming standards, Terraform layout, and module structure  
- **Access** — operator access patterns and hybrid connectivity  

Start with:

`docs/ARCHITECTURE.md`

For security details, see:

`docs/security/security-overview.md`

---

## Prerequisites

To deploy or work with this project, you will need:

- Azure subscription
- Azure CLI
- Terraform
- GitHub account (optional, for CI/CD)
- Local virtualisation platform (KVM/libvirt) for hybrid workloads

---

## Deployment

Deployment is performed through:

- Terraform (root module)
- Optional GitHub Actions CI/CD pipeline

The pipeline handles:

- Formatting and validation
- Planning
- Manual approval
- Apply

Authentication uses secure, short‑lived OIDC tokens.

---

## Future Enhancements

Potential future improvements include:

- Full management group hierarchy and subscription vending
- Azure Security Benchmark (ASB) and enterprise policy initiatives
- Additional spokes (dev/test/prod)
- Private DNS resolver
- Defender for Cloud integration
- Azure Firewall or third‑party NVAs
- Multi‑region expansion
- Policy‑as‑code modules
- Additional hybrid workloads

---

## Purpose of This Project

This project is designed as a portfolio‑ready demonstration of:

- Cloud architecture
- Hybrid connectivity
- Infrastructure‑as‑code
- DevOps automation
- Governance and policy
- Documentation quality

It reflects real‑world engineering patterns while remaining accessible and cost‑efficient.

---

## License

See the LICENSE file in the root of this project.


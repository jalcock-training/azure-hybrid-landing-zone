# Automation and CI/CD

This document describes the automation and continuous integration/continuous delivery (CI/CD) approach used in the Azure Hybrid Landing Zone project.  
The automation layer ensures that all infrastructure is deployed, updated, and governed through consistent, repeatable, and secure processes.  
Terraform provides the infrastructure-as-code (IaC) foundation, while GitHub Actions delivers the CI/CD pipeline.

For details on platform security, governance, and Terraform structure, see:
- `/docs/security/security-overview.md`
- `/docs/architecture/governance-and-policy.md`
- `/docs/reference/terraform-structure.md`

---

## 1. Automation Objectives

The automation layer is designed to:

- Ensure consistent and reproducible deployments
- Enforce validation and quality checks before changes are applied
- Use secure, ephemeral authentication mechanisms
- Support modular, scalable infrastructure growth
- Provide clear separation between planning and applying changes
- Manage hybrid and cloud resources through the same workflows
- Eliminate long‑lived credentials through identity‑based authentication
- Follow least‑privilege access principles

This approach aligns with modern engineering and enterprise DevOps practices.

---

## 2. Terraform as Infrastructure as Code

Terraform defines and manages all infrastructure components, including:

- Subscription‑level governance
- Hub and spoke networks
- Shared services (Key Vault, Storage, Log Analytics)
- Application workloads
- Azure Arc onboarding

The project uses a modular structure to promote clarity and reusability.  
For a full breakdown of module layout and responsibilities, see:  
`/docs/reference/terraform-structure.md`.

---

## 3. GitHub Actions CI/CD Pipeline

GitHub Actions provides the CI/CD pipeline for validating and deploying Terraform changes.  
The pipeline includes the following stages:

### Formatting and Validation
- `terraform fmt` ensures consistent formatting  
- `terraform validate` checks configuration correctness  
- Optional linting or static analysis can be added later  

### Planning
- `terraform plan` generates an execution plan  
- The plan is uploaded as a pipeline artifact for review  
- No changes are applied automatically  

### Manual Approval
A manual approval step ensures:
- Human oversight for all infrastructure modifications  
- Alignment with enterprise change control practices  
- Clear separation between CI (validation) and CD (deployment)  

### Apply
Once approved:
- `terraform apply` executes the plan  
- Apply operations use the same authenticated identity as planning  
- Least‑privilege permissions are enforced through Azure RBAC  

---

## 4. Secure Authentication with OIDC

The pipeline uses OpenID Connect (OIDC) to authenticate to Azure without storing long‑lived credentials.

Key characteristics:
- No secrets or service principal passwords stored in GitHub  
- Short‑lived tokens issued at workflow runtime  
- Least‑privilege access granted through Azure role assignments  
- Authentication bound to GitHub environment and branch conditions  
- No credential rotation or secret storage required  

OIDC is the recommended authentication method for GitHub‑to‑Azure workflows.

---

## 5. Environment Separation

Although the project currently uses a single environment, the automation design supports future expansion into:

- Development  
- Test  
- Production  

This can be achieved through:
- Terraform workspaces  
- Separate GitHub environments  
- Branch‑based workflows  
- Additional subscriptions or management groups  
- Environment‑specific identities and permissions  

The current implementation provides a foundation for these patterns without unnecessary complexity.

---

## 6. Drift Detection and Reconciliation

Terraform provides drift detection through the planning process:

- Changes made outside Terraform are detected  
- The plan highlights differences between desired and actual state  
- The apply stage reconciles the environment back to the declared configuration  

This ensures infrastructure remains consistent, governed, and compliant.

---

## 7. Extensibility

The automation and CI/CD pipeline can be extended to support:

- Policy compliance checks  
- Security scanning  
- Automated documentation generation  
- Integration with Azure Monitor or Defender for Cloud  
- Scheduled drift detection  
- Multi‑region or multi‑environment deployments  
- Integration with SIEM or SOC tooling  
- Enforcement of security gates based on policy or compliance results  

The current implementation focuses on core functionality while leaving room for future enhancements.


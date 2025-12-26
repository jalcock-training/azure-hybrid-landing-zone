# Automation and CI/CD

This document describes the automation and continuous integration/continuous delivery (CI/CD) approach used in the Azure Hybrid Landing Zone project. The goal of the automation layer is to ensure that all infrastructure is deployed, updated, and governed through consistent, repeatable, and secure processes. Terraform provides the infrastructure-as-code (IaC) foundation, while GitHub Actions delivers the CI/CD pipeline.

## 1. Automation Objectives

The automation layer is designed to:

- Ensure consistent and reproducible deployments
- Enforce validation and quality checks before changes are applied
- Use secure, ephemeral authentication mechanisms
- Support modular, scalable infrastructure growth
- Provide clear separation between planning and applying changes
- Enable hybrid and cloud resources to be managed through the same workflows
- Eliminate long‑lived credentials through identity‑based authentication and managed identities
- Ensure all automation follows least‑privilege access principles

The automation approach reflects modern engineering practices and aligns with enterprise DevOps patterns.

## 2. Terraform as Infrastructure as Code

Terraform is used to define and manage all infrastructure components, including:

- Subscription‑level governance (Azure Policy, RBAC, naming/tagging)
- Hub and spoke networks
- Shared services such as Log Analytics and Key Vault
- Application workloads
- Azure Arc onboarding for hybrid resources
- Security baselines enforced through policy‑driven configuration

### Terraform Structure

The project uses a modular structure to promote clarity and reusability:

- Root module for orchestration
- Child modules for:
  - Subscription‑scoped governance
  - Hub network
  - Spoke network
  - Shared services
  - Application resources
  - Azure Arc onboarding

This structure allows components to evolve independently while maintaining a clear separation of concerns.

## 3. GitHub Actions CI/CD Pipeline

GitHub Actions provides the CI/CD pipeline for validating and deploying Terraform changes. The pipeline includes the following stages:

### Formatting and Validation

- `terraform fmt` ensures consistent formatting
- `terraform validate` checks configuration correctness
- Optional linting or static analysis can be added later
- Future enhancements may include security scanning or policy compliance checks

### Planning

- `terraform plan` generates an execution plan
- The plan is uploaded as a pipeline artifact for review
- No changes are applied automatically
- Plan output is reviewed before approval to ensure changes align with governance and security expectations

### Manual Approval

A manual approval step is required before applying changes. This ensures:

- Human oversight for all infrastructure modifications
- Alignment with enterprise change control practices
- Clear separation between CI (validation) and CD (deployment)
- Security-sensitive changes (e.g., network, identity, policy) receive explicit review

### Apply

Once approved:

- `terraform apply` executes the plan
- Changes are applied using the same authenticated identity used during planning

This ensures consistency and prevents drift between plan and apply stages.
- Apply operations run with least‑privilege permissions granted to the pipeline’s managed identity

## 4. Secure Authentication with OIDC

The pipeline uses OpenID Connect (OIDC) to authenticate to Azure without storing long‑lived credentials. Key characteristics include:

- No secrets or service principal passwords stored in GitHub
- Short‑lived tokens issued at workflow runtime
- Least‑privilege access granted through Azure role assignments
- Reduced risk of credential leakage
- Authentication is bound to GitHub environment and branch conditions to prevent misuse
- Eliminates the need for secret rotation or credential storage

OIDC is the recommended authentication method for modern GitHub‑to‑Azure workflows.

## 5. Environment Separation

Although the project uses a single environment for simplicity, the automation design supports future expansion into multiple environments such as:

- Development
- Test
- Production

This can be achieved through:

- Additional Terraform workspaces
- Separate GitHub environments
- Branch‑based workflows
- Additional subscriptions or management groups in a future enterprise version
- Environment-specific identities and permissions to maintain least‑privilege boundaries

The current implementation provides a foundation for these patterns without introducing unnecessary complexity.

## 6. Drift Detection and Reconciliation

Terraform inherently provides drift detection through the planning process. When the pipeline runs:

- Any changes made outside Terraform are detected
- The plan highlights differences between desired and actual state
- The apply stage reconciles the environment back to the declared configuration

This ensures infrastructure remains consistent and governed.
- Drift detection also identifies unauthorised or accidental configuration changes, supporting security and compliance.

## 7. Extensibility

The automation and CI/CD pipeline can be extended to support:

- Policy compliance checks
- Security scanning
- Automated documentation generation
- Integration with Azure Monitor or Defender for Cloud
- Scheduled drift detection
- Multi‑region or multi‑environment deployments
- Integration with SIEM or SOC tooling for pipeline event monitoring
- Enforcement of security gates based on policy or compliance results

The current implementation focuses on core functionality while leaving room for future enhancements.

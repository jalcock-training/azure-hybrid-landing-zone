# Application Workload Architecture

This document describes the application workload used in the Azure Hybrid Landing Zone project. The workload is intentionally simple and cost‑efficient, serving as an example of how applications are deployed into a governed landing zone and how they consume shared platform services. The design demonstrates workload isolation, monitoring, and integration with the hub‑and‑spoke network model.

## 1. Purpose of the Application Workload

The application workload provides a practical example of how real workloads fit into the landing zone. Its goals are to:

- Demonstrate deployment into a spoke network
- Show how workloads consume shared services such as Log Analytics and Key Vault
- Provide a simple, low‑cost application for testing and validation
- Illustrate how governance and automation apply to workload resources
- Establish a pattern that can be extended to more complex applications

The workload is not intended to be production‑grade; it is a functional demonstration of architectural principles.

## 2. Workload Components

The workload consists of two primary Azure services:

### Azure App Service (Free Tier)

The App Service hosts a simple web application. Key characteristics include:

- Free tier to minimise cost
- Public endpoint managed by Azure (no inbound VNet access required)
- Optional VNet integration for future enhancements
- Diagnostic settings forwarding logs to the shared Log Analytics workspace
- Integration with Terraform and CI/CD pipeline

The App Service demonstrates how platform‑managed compute fits into the landing zone.

### Storage Account

A general‑purpose storage account supports the application by providing:

- Static content hosting (optional)
- Application logs or artifacts
- Diagnostic settings for monitoring
- Optional private endpoint for secure access

The storage account represents a common supporting service for cloud applications.

## 3. Network Placement

The application workload is deployed into the **spoke virtual network**, which provides:

- Isolation from the hub and other workloads
- Controlled connectivity through VNet peering
- Optional private endpoints for secure service access
- Clear separation of platform and workload responsibilities

The App Service itself does not require inbound VNet access, but the spoke network provides a foundation for future enhancements.

## 4. Integration with Shared Services

The workload consumes shared services deployed in the hub, including:

- **Log Analytics Workspace**  
  Diagnostic settings forward logs and metrics for centralised monitoring.

- **Azure Key Vault**  
  Can be used for application secrets if required in future iterations.

- **Azure Policy**  
  Ensures compliance with tagging, diagnostics, and security baselines.

This integration demonstrates how workloads benefit from centralised platform capabilities.

## 5. Governance and Compliance

The workload is governed through the same landing zone structure as other resources. This includes:

- Required tags for classification and cost management
- Policy‑driven diagnostic settings
- Allowed locations and resource types
- RBAC applied at the subscription or resource group level

This ensures the workload adheres to enterprise governance standards.

## 6. Automation and Deployment

The workload is deployed and managed through the Terraform root module and GitHub Actions pipeline. This provides:

- Consistent, repeatable deployments
- Validation and planning before changes are applied
- Secure authentication using OIDC
- Clear separation between infrastructure and application code

This demonstrates modern DevOps practices applied to cloud workloads.

## 7. Extensibility

The workload architecture is intentionally minimal but can be expanded to support more complex scenarios, including:

- API backends or microservices
- Containerised workloads using Azure Container Apps or AKS
- Private endpoints for all supporting services
- Application secrets stored in Key Vault
- Multi‑environment deployments (dev/test/prod)
- Integration with CI/CD pipelines for application code

The current implementation provides a simple but realistic foundation for cloud application deployment.



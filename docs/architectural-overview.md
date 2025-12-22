# Architectural Overview

This document provides a high‑level architectural overview of the Azure Hybrid Landing Zone project. It describes the major components, their relationships, and the design principles guiding the implementation. The goal is to demonstrate a secure, scalable, and automation‑driven cloud foundation that integrates both native Azure resources and on‑premises infrastructure through Azure Arc.

## 1. Architecture Summary

The solution is built around three core pillars:

1. Azure Landing Zone: the governance and management foundation that defines identity, policy, RBAC, and subscription structure.
2. Platform and Workload Infrastructure: a hub‑and‑spoke network topology hosting shared services in the hub and application workloads in the spoke.
3. Hybrid Integration: an on‑premises Linux virtual machine onboarded to Azure using Azure Arc, enabling governance and configuration management from the cloud.

Automation is provided through Terraform and GitHub Actions, ensuring consistent, repeatable deployments across all layers.

## 2. Azure Landing Zone

The landing zone establishes the enterprise governance model for the environment. It includes:

- Management group hierarchy (Root, Platform, Landing Zones)
- Azure Policy assignments for baseline governance
- RBAC model for least‑privilege access
- Subscription structure separating platform services from workloads
- Naming and tagging standards applied consistently across resources

This layer provides the control plane for both cloud and hybrid resources.

## 3. Hub Network and Shared Services

The hub virtual network hosts shared services and acts as the central connectivity point for the environment. Key components include:

- Hub virtual network and subnets
- Log Analytics workspace for monitoring and diagnostics
- Azure Key Vault (Standard tier) for secret management
- Optional shared services such as Bastion or Automation Account
- VNet peering to spoke networks

The hub is designed to be lightweight and cost‑efficient while still representing enterprise patterns.

## 4. Spoke Network and Application Workload

The spoke network hosts the example workload used to demonstrate application deployment and network isolation. Components include:

- Spoke virtual network and subnets
- Azure App Service (Free tier) for the sample web application
- Storage account for application assets or logs
- Optional private endpoints for secure service access
- Diagnostic settings forwarding logs to the shared Log Analytics workspace

This structure reflects a typical application landing zone within an enterprise environment.

## 5. Hybrid On‑Premises Environment (Azure Arc)

A small on‑premises Linux virtual machine, hosted on a local KVM hypervisor, is onboarded to Azure using Azure Arc. This enables:

- Centralised governance through Azure Policy
- Inventory and metadata visibility in Azure Resource Manager
- Optional monitoring via Log Analytics
- Configuration management and updates delivered through GitHub Actions

The hybrid component demonstrates how Azure can manage resources outside the cloud using the same governance and automation patterns.

## 6. Automation and Deployment Pipeline

Infrastructure is provisioned and updated using Terraform, with GitHub Actions providing CI/CD automation. The pipeline includes:

- Terraform formatting, validation, and planning
- Manual approval for apply operations
- OIDC‑based authentication from GitHub to Azure
- Modular Terraform structure for hub, spoke, shared services, and Arc onboarding

This ensures deployments are consistent, repeatable, and aligned with modern engineering practices.

## 7. Future Enhancements

The architecture is intentionally minimal to control cost while remaining extensible. Potential future improvements include:

- Additional spokes for multi‑environment scenarios
- Azure Firewall or third‑party network virtual appliances
- Private DNS zones and more advanced name resolution
- Arc‑enabled Kubernetes or container workloads
- Defender for Cloud integration
- Expanded monitoring and alerting

These enhancements can be added incrementally as the project evolves.

## 8. Diagram Reference

The high‑level architecture diagram associated with this document is located in the `/diagrams` directory of this repository. It illustrates the relationships between the landing zone, hub and spoke networks, hybrid environment, and automation pipeline.

_Last updated: see commit history_

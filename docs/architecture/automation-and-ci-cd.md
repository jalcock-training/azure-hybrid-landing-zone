# Automation and CI/CD

## Overview

Automation in this landing zone is built around Terraform modules, remote state, and a clean separation of platform and workload layers. CI/CD integration is planned for Phase 2.

## Current Automation (Phase 1)

- Terraform modules for all platform components
- Remote state stored in Azure Storage
- Feature toggles for governance, diagnostics, and private endpoints
- Clean variable structure
- Consistent naming and tagging
- Manual apply workflow

## Planned Automation (Phase 2)

- GitHub Actions pipeline using OIDC authentication
- Automated policy compliance checks
- Drift detection
- Automated documentation validation
- Optional pre-deployment security scanning

## Rationale

Phase 1 focuses on correctness and modularity.  
Phase 2 introduces automation once the architecture is stable and complete.

This mirrors real-world landing zone evolution: build the foundation first, then automate.


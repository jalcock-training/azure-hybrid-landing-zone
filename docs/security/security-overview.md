# Security Overview

## Security Principles

The landing zone follows these principles:

- Identity-driven access
- Private-endpoint-first design
- No public ingress
- Least-privilege RBAC
- Secure-by-default configuration
- Immutable infrastructure patterns where possible

## Phase 1 Security Posture

- MFA enforced for operators
- No classic administrators
- Private endpoints for all PaaS services
- No public IPs on VMs
- NSGs with deny-all inbound
- Soft delete and purge protection on Key Vault
- TLS 1.2+ enforced
- Activity Log export enabled

## Phase 2 Security Enhancements

- Defender for Cloud suite
- Azure Firewall
- Just-In-Time VM Access
- Sentinel
- Diagnostic settings for all resources
- Alerting and anomaly detection
- Enforcement policies
- Identity lifecycle management

## Rationale

Security is layered, starting with a minimal but strong free-tier baseline and expanding into enterprise-grade controls in Phase 2.


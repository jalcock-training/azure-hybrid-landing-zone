# Hybrid01 Architecture

## Purpose

Hybrid01 is a minimal SSH relay VM that provides controlled access into the hybrid environment. It prevents direct access to Hybrid02 and avoids exposing any public SSH endpoints.

## Key Characteristics

- No public IP
- No Azure identity
- Static IP (192.168.122.101)
- Port forwarding enabled
- Minimal cloud-init configuration
- Stores relay private key for Hybrid02 access
- Runs on libvirt/KVM

## Cloud-Init Summary

Hybrid01 cloud-init performs:

- Creation of relay user
- Injection of SSH keys
- Enabling TCP forwarding
- Restarting SSH service

No Azure CLI or identity components are installed.

## Rationale

- Provides a secure entry point into the hybrid environment
- Reduces attack surface by avoiding public SSH
- Keeps trust boundaries tight
- Ensures Hybrid02 is never directly exposed


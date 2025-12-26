# Jump ACI Module

This module deploys an ephemeral Azure Container Instance (ACI) that acts as a
lightweight jump environment for accessing the jumphost VM. The container
includes an entrypoint script that manages the full lifecycle of the VM,
ensuring the environment is only running when actively in use.

## Overview

The jump‑ACI provides a controlled operator workflow:

1. Start the ACI container.
2. Exec into the container and SSH to the jumphost VM.
3. When SSH activity stops, the container idles.
4. After the configured timeout, the container exits.
5. The entrypoint cleanup logic deallocates the VM.

This pattern keeps the environment cost‑efficient, predictable, and easy to
operate without requiring long‑running infrastructure.

## Lifecycle Behaviour

The container’s `entrypoint.sh` script:

- Starts the jumphost VM on container startup.
- Monitors for active SSH sessions inside the container.
- Tracks idle time when no SSH processes are running.
- Exits when the idle timeout is reached.
- Deallocates the jumphost VM via a cleanup trap on exit.

This ensures the VM is only powered on when needed and automatically shuts down
when the operator session ends.

## Inputs

Key inputs include:

- `resource_group_name` – Resource group for the ACI and VM.
- `location` – Azure region.
- `ssh_private_key` – Private key injected into the container for SSH access.
- `vm_name` – Name of the jumphost VM to manage.
- `idle_timeout_seconds` – Idle period before the container shuts down.

## Outputs

The module exposes:

- `aci_name` – Name of the deployed container group.
- `identity_id` – User‑assigned managed identity used by the container.

## Operator Workflow

The `scripts/` directory provides helper scripts for interacting with the jump
environment:

- `jump-start.sh` – Start the ACI and open a shell.
- `jump-status.sh` – Check ACI and VM state.
- `jump-stop.sh` – Stop the ACI (which triggers VM deallocation).

These scripts provide a simple, consistent interface for operators without
needing to interact directly with the Azure CLI or Terraform.

## Design Notes

- The ACI uses a user‑assigned managed identity to control the jumphost VM.
- The SSH private key is injected as an environment variable and written to
  `/root/.ssh/id_rsa` on container startup.
- The container is intentionally ephemeral; no state is stored between runs.
- The module is designed to be safe to recreate. Redeploying the ACI preserves
  the existing SSH key unless the input variable changes.

## When to Use This Module

This module is ideal when you need:

- A controlled, auditable jump environment.
- A cost‑efficient VM that only runs during active use.
- A predictable operator workflow for accessing private resources.
- A clean separation between operator access and the rest of the landing zone.

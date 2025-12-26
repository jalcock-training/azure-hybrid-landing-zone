# Scripts

Helper scripts used to operate the jump environment. These scripts provide a
simple, consistent workflow for starting, stopping, and inspecting the
ephemeral jump‑ACI container and the jumphost VM.

## jump-start.sh
Starts the jump‑ACI container group, waits for it to reach a running state, and
opens an interactive shell inside the container. From there, operators can SSH
to the jumphost VM.

Usage:
./scripts/jump-start.sh

## jump-status.sh
Displays the current state of both the jump‑ACI container group and the
jumphost VM.

Usage:
./scripts/jump-status.sh

## jump-stop.sh
Stops the jump‑ACI container group. The container’s `entrypoint.sh` includes a
cleanup trap that deallocates the jumphost VM when the container stops.

Usage:
./scripts/jump-stop.sh

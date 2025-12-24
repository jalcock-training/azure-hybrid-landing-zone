#!/bin/sh
set -e

###############################################################################
# entrypoint.sh
#
# Purpose:
#   Make the ACI jump container behave as an ephemeral access point.
#   - When the container starts → start the jumphost VM.
#   - While the container is active → keep the VM running.
#   - When the container goes idle → exit.
#   - On exit → deallocate the VM.
#
# Why:
#   ACI has no native idle shutdown. This script adds that behaviour so the
#   jump environment stays secure, automated, and low‑cost.
###############################################################################

IDLE_TIMEOUT=900   # 15 minutes
LAST_ACTIVE=$(date +%s)

echo "Starting jumphost VM..."
az vm start --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"

echo "Writing private SSH key..."
mkdir -p /home/azureuser/.ssh
echo "$SSH_PRIVATE_KEY" > /home/azureuser/.ssh/jumphost
chmod 600 /home/azureuser/.ssh/jumphost

echo "Jump container ready. Monitoring for idle activity..."

cleanup() {
  echo "Stopping jumphost VM..."
  az vm deallocate --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"
}
trap cleanup EXIT

while true; do
  ACTIVE_SESSIONS=$(ps aux | grep -E "bash|sh" | grep -v grep | wc -l)

  if [ "$ACTIVE_SESSIONS" -gt 1 ]; then
    LAST_ACTIVE=$(date +%s)
  fi

  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_ACTIVE))

  if [ "$ELAPSED" -ge "$IDLE_TIMEOUT" ]; then
    echo "Idle timeout reached. Shutting down ACI..."
    exit 0
  fi

  sleep 30
done


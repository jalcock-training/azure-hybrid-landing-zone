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
mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

echo "Jump container ready. Monitoring for idle activity..."

cleanup() {
  echo "Stopping jumphost VM..."
  az vm deallocate --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"
}
trap cleanup EXIT

# -----------------------------------------------------------------------------
# Keep container alive for exec sessions
# -----------------------------------------------------------------------------
# This runs in the background and ensures the container stays in 'Running'
# state so 'az container exec' works. The idle loop below still determines
# when the container should exit.
tail -f /dev/null &
KEEPALIVE_PID=$!

# -----------------------------------------------------------------------------
# Idle monitoring loop
# -----------------------------------------------------------------------------

while true; do
  ACTIVE_SESSIONS=$(pgrep ssh | wc -l)

  if [ "$ACTIVE_SESSIONS" -gt 0 ]; then
    LAST_ACTIVE=$(date +%s)
  fi

  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_ACTIVE))

  if [ "$ELAPSED" -ge "$IDLE_TIMEOUT" ]; then
    echo "Idle timeout reached. Shutting down ACI..."
    kill $KEEPALIVE_PID 2>/dev/null || true
    exit 0
  fi

  sleep 30
done


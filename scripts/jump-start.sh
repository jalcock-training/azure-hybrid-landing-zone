#!/bin/bash
set -e

###############################################################################
# jump-start.sh
#
# Starts the jump‑ACI container, waits until it's running, then opens an
# interactive shell inside it.
###############################################################################

RESOURCE_GROUP="rg-platform"
ACI_NAME="jump-aci"

echo "Starting ACI container group: $ACI_NAME"
az container start -g "$RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null

# Wait for container to reach 'Running' state
echo "Waiting for ACI to reach 'Running' state..."
while true; do
    STATE=$(az container show \
        -g "$RESOURCE_GROUP" \
        -n "$ACI_NAME" \
        --query "instanceView.state" \
        -o tsv)

    [ "$STATE" = "Running" ] && break
    sleep 2
done

# Open interactive shell
echo "ACI is running. Opening shell..."
az container exec \
    -g "$RESOURCE_GROUP" \
    -n "$ACI_NAME" \
    --exec-command "/bin/bash"

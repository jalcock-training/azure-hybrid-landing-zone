#!/bin/bash
set -e

###############################################################################
# jump-start.sh
#
# Starts the jump VM (asynchronously) and the jump ACI container, waits only
# for the ACI container to reach 'Running', then opens an interactive shell.
###############################################################################

# VM details
VM_RESOURCE_GROUP="rg-hub"
VM_NAME="jumphost"

# ACI details
ACI_RESOURCE_GROUP="rg-hub"
ACI_NAME="jump-aci"

###############################################################################
# Start VM (no waiting)
###############################################################################

echo "Starting Jump VM: $VM_NAME (no wait)"
az vm start -g "$VM_RESOURCE_GROUP" -n "$VM_NAME" >/dev/null &

###############################################################################
# Start ACI
###############################################################################

echo "Starting ACI container group: $ACI_NAME"
az container start -g "$ACI_RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null

echo "Waiting for ACI to reach 'Running' state..."
while true; do
    ACI_STATE=$(az container show \
        -g "$ACI_RESOURCE_GROUP" \
        -n "$ACI_NAME" \
        --query "instanceView.state" \
        -o tsv)

    [ "$ACI_STATE" = "Running" ] && break
    sleep 2
done

###############################################################################
# Exec into ACI
###############################################################################

echo "ACI is running. Opening shell..."
az container exec \
    -g "$ACI_RESOURCE_GROUP" \
    -n "$ACI_NAME" \
    --exec-command "/bin/bash"


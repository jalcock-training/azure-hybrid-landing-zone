#!/bin/bash
set -e

###############################################################################
# jump-status.sh
#
# Shows the current state of the jump‑ACI container and the jumphost VM.
###############################################################################

RESOURCE_GROUP="rg-platform"
ACI_NAME="jump-aci"
VM_NAME="jumphost"

echo "Checking jump environment status..."
echo

# ACI container state
ACI_STATE=$(az container show \
    -g "$RESOURCE_GROUP" \
    -n "$ACI_NAME" \
    --query "instanceView.state" \
    -o tsv 2>/dev/null || echo "NotFound")

echo "Jump‑ACI:"
echo "  - Status: $ACI_STATE"
echo

# VM power state
VM_STATE=$(az vm get-instance-view \
    -g "$RESOURCE_GROUP" \
    -n "$VM_NAME" \
    --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" \
    -o tsv 2>/dev/null || echo "NotFound")

echo "Jumphost VM:"
echo "  - Status: $VM_STATE"
echo

echo "Status check complete."

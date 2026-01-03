#!/bin/bash
set -e

###############################################################################
# jump-stop.sh
#
# Stops the jump VM and the jump ACI container group.
###############################################################################

# VM details
VM_RESOURCE_GROUP="rg-hub"
VM_NAME="vm-jumphost"

# ACI details
ACI_RESOURCE_GROUP="rg-hub"
ACI_NAME="jump-aci"

###############################################################################
# Stop ACI
###############################################################################

echo "Stopping ACI container group: $ACI_NAME"
az container stop -g "$ACI_RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null || true
echo "ACI stop request submitted."

###############################################################################
# Stop VM
###############################################################################

echo "Stopping Jump VM: $VM_NAME"
az vm deallocate -g "$VM_RESOURCE_GROUP" -n "$VM_NAME" >/dev/null || true
echo "VM deallocate request submitted."


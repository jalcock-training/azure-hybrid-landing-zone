#!/bin/bash
set -e

###############################################################################
# jump-stop.sh
#
# Stops the jump VM, the workload VM, and the jump ACI container group.
###############################################################################

# Jump VM details
JUMP_VM_RESOURCE_GROUP="rg-hub"
JUMP_VM_NAME="jumphost"

# Workload VM details
WORKLOAD_VM_RESOURCE_GROUP="rg-spoke01"
WORKLOAD_VM_NAME="ahlz-spoke01-dev-workload"

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
# Stop Jump VM
###############################################################################

echo "Stopping Jump VM: $JUMP_VM_NAME"
az vm deallocate -g "$JUMP_VM_RESOURCE_GROUP" -n "$JUMP_VM_NAME" >/dev/null || true
echo "Jump VM deallocate request submitted."

###############################################################################
# Stop Workload VM
###############################################################################

echo "Stopping Workload VM: $WORKLOAD_VM_NAME"
az vm deallocate -g "$WORKLOAD_VM_RESOURCE_GROUP" -n "$WORKLOAD_VM_NAME" >/dev/null || true
echo "Workload VM deallocate request submitted."


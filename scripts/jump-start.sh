#!/bin/bash
set -e

###############################################################################
# jump-start.sh
#
# Starts the jump ACI container group, the jump VM, and the workload VM.
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
# Start ACI
###############################################################################

echo "Starting ACI container group: $ACI_NAME"
az container start -g "$ACI_RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null || true
echo "ACI start request submitted."

###############################################################################
# Start Jump VM
###############################################################################

echo "Starting Jump VM: $JUMP_VM_NAME"
az vm start -g "$JUMP_VM_RESOURCE_GROUP" -n "$JUMP_VM_NAME" >/dev/null || true
echo "Jump VM start request submitted."

###############################################################################
# Start Workload VM
###############################################################################

#echo "Starting Workload VM: $WORKLOAD_VM_NAME"
#az vm start -g "$WORKLOAD_VM_RESOURCE_GROUP" -n "$WORKLOAD_VM_NAME" >/dev/null || true
#echo "Workload VM start request submitted."


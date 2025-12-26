#!/bin/bash
set -e

###############################################################################
# jump-stop.sh
#
# Stops the jump‑ACI container group. The container's entrypoint.sh includes 
# a cleanup trap that deallocates the jumphost VM when the container stops.
###############################################################################

RESOURCE_GROUP="rg-platform"
ACI_NAME="jump-aci"

echo "Stopping ACI container group: $ACI_NAME"
az container stop -g "$RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null

echo "ACI stop request submitted."

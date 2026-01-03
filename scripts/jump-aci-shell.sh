#!/bin/bash
set -e

###############################################################################
# jump-aci-shell.sh
#
# Creates a shell in the jump-aci container
###############################################################################

RESOURCE_GROUP="rg-hub"
ACI_NAME="jump-aci"

az container exec \
    -g "$RESOURCE_GROUP" \
    -n "$ACI_NAME" \
    --exec-command "/bin/bash"

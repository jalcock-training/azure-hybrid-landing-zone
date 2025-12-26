#!/bin/bash
set -e

RESOURCE_GROUP="rg-platform"
ACI_NAME="jump-aci"

echo "Starting ACI container group: $ACI_NAME"
az container start -g "$RESOURCE_GROUP" -n "$ACI_NAME" >/dev/null

echo "Waiting for ACI to reach 'Running' state..."
while true; do
    STATE=$(az container show -g "$RESOURCE_GROUP" -n "$ACI_NAME" --query "instanceView.state" -o tsv)
    if [ "$STATE" = "Running" ]; then
        break
    fi
    sleep 2
done

echo "ACI is running. Opening shell..."
az container exec -g "$RESOURCE_GROUP" -n "$ACI_NAME" --exec-command "/bin/sh"

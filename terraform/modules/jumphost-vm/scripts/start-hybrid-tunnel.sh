#!/bin/bash

set -e

TUNNEL_NAME="hybrid-relay-tunnel"
SSH_KEY="/home/azureuser/.ssh/relay_id_rsa"

# Check if tunnel already running
if pgrep -f "ssh -N -R" >/dev/null; then
    echo "Tunnel already running. Nothing to do."
    exit 0
fi

echo "Enter the public IP of hybrid01:"
read HYBRID_IP

echo "Enter the forwarded SSH port on your router:"
read HYBRID_PORT

# Validate key exists
if [ ! -f "$SSH_KEY" ]; then
    echo "ERROR: SSH key not found at $SSH_KEY"
    exit 1
fi

echo "Starting reverse tunnel..."
nohup ssh -i "$SSH_KEY" \
    -o StrictHostKeyChecking=no \
    -o ServerAliveInterval=60 \
    -o ServerAliveCountMax=3 \
    -N \
    -R 443:ahlz-ss-dev-keyvault01.vaultcore.azure.net:443 \
    relay@"$HYBRID_IP" -p "$HYBRID_PORT" \
    >/var/log/$TUNNEL_NAME.log 2>&1 &

sleep 2

if pgrep -f "ssh -N -R" >/dev/null; then
    echo "Tunnel established successfully."
else
    echo "Tunnel failed to start. Check /var/log/$TUNNEL_NAME.log"
fi


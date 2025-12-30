#!/bin/sh
set -e

###############################################################################
# entrypoint.sh
#
# Simplified version:
#   - Start the jumphost VM
#   - Decode and write SSH key
#   - Stay alive until 03:00 local time
#   - Exit → cleanup trap deallocates the VM
###############################################################################

echo "Writing private SSH key..."
mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY_B64" | base64 -d > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

echo "Jump container ready. Will shut down at 03:00."

# No cleanup trap needed since we aren't calling Azure APIs anymore

while true; do
  NOW=$(date +%H:%M)
  if [ "$NOW" = "03:00" ]; then
    echo "It's 03:00. Exiting container..."
    exit 0
  fi
  sleep 30
done


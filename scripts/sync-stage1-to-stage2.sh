#!/bin/bash
set -e

###############################################################################
# sync-stage1-to-stage2.sh
#
# Exports all Terraform outputs from stage1-bootstrap and writes them into
# stage2-workloads as an auto-loaded .tfvars.json file.
#
# Terraform will automatically load any file ending in *.auto.tfvars.json,
# so stage2 will pick these values up with no extra flags.
###############################################################################

STAGE1_DIR="../terraform/stage1-bootstrap"
# Stage2 has to be relatve to the stage1 dir
STAGE2_DIR="../stage2-workloads"
OUTPUT_FILE="stage1_outputs.auto.tfvars.json"

echo "Exporting stage1 outputs..."

# Move into stage1
cd "$STAGE1_DIR"

# Ensure state is accessible
#terraform refresh >/dev/null 2>&1 || true
#terraform refresh  

# Export outputs as JSON directly into stage2
#terraform output -json > "$STAGE2_DIR/$OUTPUT_FILE"
terraform output -json -no-color -refresh=false | jq 'map_values(.value)' > "$STAGE2_DIR/stage1_outputs.auto.tfvars.json"


echo "Outputs written to: $STAGE2_DIR/$OUTPUT_FILE"
echo "Stage2 will automatically load these values on next plan/apply."


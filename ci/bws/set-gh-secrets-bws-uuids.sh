#!/bin/bash

DEV_GH_ENV="dev"
PROD_GH_ENV="live"

DEV_BWS_TOKEN="0.b745f1f6-8583-4576-9eac-b4bc00fa6a3f.oZNVVGXtgs0ZVg1PSDgBnM7bZyweaZ:8/E1qhigoWUG2HriTm0V7g=="
PROD_BWS_TOKEN="0.174b52f3-2a6e-4d0a-9ea2-b4bc01211b2d.buPb7WQDPJwXFS9dzButbtkjNXujBO:Bn+ad65JuUZc66Y8YNrhiA=="
BWS_SERVER="https://vault.bitwarden.eu" # Set to EU cloud

export BWS_SERVER_URL="$BWS_SERVER"


echo "1. Fetching GitHub Variables from '$DEV_GH_ENV'..."
# Gets pairs of Name:Value (GH_VAR_NAME:DEV_UUID)
GH_DEV_VARS=$(gh variable list --env "$DEV_GH_ENV" --json name,value | jq -r '.[] | "\(.name):\(.value)"')

echo "2. Fetching Dev BWS Secrets..."
export BWS_ACCESS_TOKEN="$DEV_BWS_TOKEN"
# Creates mapping of Dev_UUID:Secret_Key
DEV_BWS_SECRETS=$(bws secret list | jq -r '.[] | "\(.id):\(.key)"')

echo "3. Switching to Prod BWS and Fetching Secrets..."
export BWS_ACCESS_TOKEN="$PROD_BWS_TOKEN"
# Creates mapping of Secret_Key:Prod_UUID
PROD_BWS_SECRETS=$(bws secret list | jq -r '.[] | "\(.key):\(.id)"')

echo "4. Cross-referencing and migrating to '$PROD_GH_ENV' GitHub Environment..."
echo "--------------------------------------------------------"

for GH_VAR in $GH_DEV_VARS; do
    # Extract GitHub Variable Name and Dev UUID
    GH_VAR_NAME="${GH_VAR%%:*}"
    DEV_UUID="${GH_VAR#*:}"
    
    # 1. Look up the Secret Name using the Dev UUID
    SECRET_KEY=$(echo "$DEV_BWS_SECRETS" | grep "^$DEV_UUID:" | cut -d':' -f2-)
    
    if [ -z "$SECRET_KEY" ]; then
        # Skips standard variables that aren't BWS UUIDs
        continue
    fi
    
    # 2. Look up the Prod UUID using that Secret Name
    PROD_UUID=$(echo "$PROD_BWS_SECRETS" | grep "^$SECRET_KEY:" | cut -d':' -f2-)
    
    if [ -z "$PROD_UUID" ]; then
        echo "[Error] No Prod BWS Secret found with key '$SECRET_KEY' (GH Var: $GH_VAR_NAME)"
        continue
    fi
    
    # 3. Inject the new Prod UUID into the Prod GitHub Environment
    echo "Mapping $GH_VAR_NAME (Key: $SECRET_KEY) -> $PROD_UUID"
    gh variable set "$GH_VAR_NAME" --env "$PROD_GH_ENV" --body "$PROD_UUID"
    
done

echo "--------------------------------------------------------"
echo "Done! All GitHub Actions variables are set for Production."
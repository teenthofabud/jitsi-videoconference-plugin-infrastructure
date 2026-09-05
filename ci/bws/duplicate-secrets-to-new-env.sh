
export BWS_ACCESS_TOKEN=""
# 1. Paste your IDs here
SOURCE_PROJECT=""
TARGET_PROJECT=""

# 2. Run the loop to copy them over
bws secret list | jq -c ".[] | select(.projectId == \"$SOURCE_PROJECT\")" | while read -r secret; do
  KEY=$(echo "$secret" | jq -r '.key')
  VALUE=$(echo "$secret" | jq -r '.value')
  
  echo "Duplicating $KEY..."
  bws secret create "$KEY" "$VALUE" "s$TARGET_PROJECT"
done

echo "Done! All secrets duplicated."
TF_USER_NAME="terraform-jitsi-provisioner"

echo "Cleaning up IAM user: ${TF_USER_NAME}"

if aws iam get-user --user-name "${TF_USER_NAME}" >/dev/null 2>&1; then
  echo "IAM user exists. Removing attached resources..."

  echo "Deleting access keys..."
  ACCESS_KEY_IDS=$(
    aws iam list-access-keys \
      --user-name "${TF_USER_NAME}" \
      --query "AccessKeyMetadata[].AccessKeyId" \
      --output text
  )

  for ACCESS_KEY_ID in ${ACCESS_KEY_IDS}; do
    echo "Deleting access key: ${ACCESS_KEY_ID}"
    aws iam delete-access-key \
      --user-name "${TF_USER_NAME}" \
      --access-key-id "${ACCESS_KEY_ID}"
  done

  echo "Detaching managed policies..."
  ATTACHED_POLICY_ARNS=$(
    aws iam list-attached-user-policies \
      --user-name "${TF_USER_NAME}" \
      --query "AttachedPolicies[].PolicyArn" \
      --output text
  )

  for POLICY_ARN in ${ATTACHED_POLICY_ARNS}; do
    echo "Detaching policy: ${POLICY_ARN}"
    aws iam detach-user-policy \
      --user-name "${TF_USER_NAME}" \
      --policy-arn "${POLICY_ARN}"
  done

  echo "Deleting inline user policies..."
  INLINE_POLICY_NAMES=$(
    aws iam list-user-policies \
      --user-name "${TF_USER_NAME}" \
      --query "PolicyNames[]" \
      --output text
  )

  for POLICY_NAME in ${INLINE_POLICY_NAMES}; do
    echo "Deleting inline policy: ${POLICY_NAME}"
    aws iam delete-user-policy \
      --user-name "${TF_USER_NAME}" \
      --policy-name "${POLICY_NAME}"
  done

  echo "Deleting login profile if present..."
  aws iam delete-login-profile \
    --user-name "${TF_USER_NAME}" \
    >/dev/null 2>&1 || true

  echo "Deleting IAM user..."
  aws iam delete-user \
    --user-name "${TF_USER_NAME}"

  echo "Deleted IAM user: ${TF_USER_NAME}"
else
  echo "IAM user does not exist: ${TF_USER_NAME}"
fi
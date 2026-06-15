#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".env" ]]; then
  set -a
  source .env
  set +a
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POLICY_TEMPLATE_FILE="${SCRIPT_DIR}/terraform-jitsi-provisioning-policy.json"
GENERATED_ENV_FILE="${SCRIPT_DIR}/.floci-terraform.env"

if [[ ! -f "${POLICY_TEMPLATE_FILE}" ]]; then
  echo "Policy file not found: ${POLICY_TEMPLATE_FILE}"
  exit 1
fi

# Local emulation using floci.io
export AWS_ENDPOINT_URL="http://localhost:4566"
export AWS_DEFAULT_REGION="eu-central-1"

# Bootstrap credentials for local emulator
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"

FLOCI_IMAGE="floci/floci:latest"
FLOCI_PORT="4566"
FLOCI_VOLUME_NAME="jitsi-floci-local-data"

# Update this if Floci documents a different internal data directory.
FLOCI_DATA_DIR="/data"

TF_USER_NAME="terraform-jitsi-provisioner"
TF_POLICY_NAME="TerraformJitsiS3AndGithubOidcProvisioningPolicy"
TF_STATE_BUCKET="jitsi-local-tfstate"

echo "Checking for existing Floci container..."

EXISTING_CONTAINER_ID=$(
  docker ps -a \
    --filter "ancestor=$FLOCI_IMAGE" \
    --format "{{.ID}}"
)

RUNNING_CONTAINER_ID=$(
  docker ps \
    --filter "ancestor=$FLOCI_IMAGE" \
    --format "{{.ID}}"
)

if [[ -n "${RUNNING_CONTAINER_ID:-}" ]]; then
  echo "Floci container is already running: ${RUNNING_CONTAINER_ID}"
elif [[ -n "${EXISTING_CONTAINER_ID:-}" ]]; then
  echo "Found existing stopped Floci container: ${EXISTING_CONTAINER_ID}"
  echo "Starting existing Floci container..."
  docker start "${EXISTING_CONTAINER_ID}" >/dev/null
  echo "Started Floci container: ${EXISTING_CONTAINER_ID}"
else
  echo "No existing Floci container found."
  echo "Creating Docker volume: ${FLOCI_VOLUME_NAME}"
  docker volume create "${FLOCI_VOLUME_NAME}" >/dev/null

  echo "Starting new Floci container: ${FLOCI_IMAGE}"
  docker run -d \
    -p "${FLOCI_PORT}:4566" \
    -v "${FLOCI_VOLUME_NAME}:${FLOCI_DATA_DIR}" \
    "${FLOCI_IMAGE}" >/dev/null

  echo "Started new Floci container"
fi

ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
echo "Using local AWS account id: ${ACCOUNT_ID}"

RENDERED_POLICY_FILE="$(mktemp)"

sed \
  -e "s/<ACCOUNT_ID>/${ACCOUNT_ID}/g" \
  -e "s/<TF_STATE_BUCKET>/${TF_STATE_BUCKET}/g" \
  "${POLICY_TEMPLATE_FILE}" > "${RENDERED_POLICY_FILE}"

POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${TF_POLICY_NAME}"

echo "Checking Terraform IAM user..."
if aws iam get-user --user-name "${TF_USER_NAME}" >/dev/null 2>&1; then
  echo "Terraform IAM user already exists: ${TF_USER_NAME}"
else
  echo "Creating Terraform IAM user: ${TF_USER_NAME}"
  aws iam create-user \
    --user-name "${TF_USER_NAME}" \
    >/dev/null
fi

echo "Checking Terraform provisioning policy..."
if aws iam get-policy --policy-arn "${POLICY_ARN}" >/dev/null 2>&1; then
  echo "Terraform provisioning policy already exists: ${TF_POLICY_NAME}"
else
  echo "Creating Terraform provisioning policy: ${TF_POLICY_NAME}"
  aws iam create-policy \
    --policy-name "${TF_POLICY_NAME}" \
    --policy-document "file://${RENDERED_POLICY_FILE}" \
    >/dev/null
fi

echo "Checking whether policy is already attached to Terraform user..."
ATTACHED_POLICY_COUNT=$(
  aws iam list-attached-user-policies \
    --user-name "${TF_USER_NAME}" \
    --query "AttachedPolicies[?PolicyArn=='${POLICY_ARN}'] | length(@)" \
    --output text
)

if [[ "${ATTACHED_POLICY_COUNT}" == "0" ]]; then
  echo "Attaching policy to Terraform user..."
  aws iam attach-user-policy \
    --user-name "${TF_USER_NAME}" \
    --policy-arn "${POLICY_ARN}" \
    >/dev/null
else
  echo "Policy already attached to Terraform user."
fi

rm -f "${RENDERED_POLICY_FILE}"

# If we already saved generated credentials earlier, reuse them.
if [[ -f "${GENERATED_ENV_FILE}" ]]; then
  echo "Loading existing Terraform IAM user credentials from ${GENERATED_ENV_FILE}"
  set -a
  source "${GENERATED_ENV_FILE}"
  set +a
else
  echo "No saved Terraform IAM user credentials found."

  EXISTING_ACCESS_KEY_COUNT=$(
    aws iam list-access-keys \
      --user-name "${TF_USER_NAME}" \
      --query "length(AccessKeyMetadata)" \
      --output text
  )

  if [[ "${EXISTING_ACCESS_KEY_COUNT}" != "0" ]]; then
    echo "Access key already exists for ${TF_USER_NAME}, but secret access key cannot be retrieved."
    echo "Either delete the existing access key manually or provide credentials in:"
    echo "${GENERATED_ENV_FILE}"
    exit 1
  fi

  echo "Creating access key for Terraform user..."

  ACCESS_KEY_PAIR=$(
    aws iam create-access-key \
      --user-name "${TF_USER_NAME}" \
      --query 'AccessKey.[AccessKeyId,SecretAccessKey]' \
      --output text
  )

  read -r AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY <<< "${ACCESS_KEY_PAIR}"

  if [[ -z "${AWS_ACCESS_KEY_ID:-}" || -z "${AWS_SECRET_ACCESS_KEY:-}" ]]; then
    echo "Failed to create or parse Terraform IAM user access key."
    exit 1
  fi

  cat > "${GENERATED_ENV_FILE}" <<EOF
export AWS_ENDPOINT_URL="${AWS_ENDPOINT_URL}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
EOF

  echo "Saved Terraform IAM user credentials to ${GENERATED_ENV_FILE}"
fi

export AWS_ENDPOINT_URL
export AWS_DEFAULT_REGION
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

echo "Now using Terraform IAM user credentials:"
echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
echo "AWS_SECRET_ACCESS_KEY=***"

echo "Creating Terraform state bucket using Terraform IAM user..."
aws s3api create-bucket \
  --bucket "${TF_STATE_BUCKET}" \
  >/dev/null 2>&1 || true

echo "Initializing Terraform..."
terraform init -reconfigure -backend-config=backendfiles/backend.local.conf 

echo "Running Terraform plan..."
terraform plan -var-file=envs/dev.tfvars

echo "Running Terraform apply..."
terraform apply -var-file=envs/dev.tfvars
terraform {
  required_providers {

    bitwarden-secrets = {
      source = "registry.terraform.io/bitwarden/bitwarden-secrets"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }

  }
  required_version = ">= 1.1.0"
}

provider "cloudflare" {}

provider "aws" {
  region = var.aws_region

  # If local mocking using floci isn't needed, only region property
  # has to be kept, everything else can be removed
  access_key                  = var.use_local_mock ? "mock_key" : null
  secret_key                  = var.use_local_mock ? "mock_secret" : null
  skip_credentials_validation = var.use_local_mock
  skip_metadata_api_check     = var.use_local_mock
  skip_requesting_account_id  = var.use_local_mock

  # Dynamically switch endpoints based on your flag
  dynamic "endpoints" {
    for_each = var.use_local_mock ? [1] : []
    content {
      s3       = "http://localhost:4566"
      iam      = "http://localhost:4566"
      sts      = "http://localhost:4566"
      ssm      = "http://localhost:4566"
      dynamodb = "http://localhost:4566"
    }
  }
}
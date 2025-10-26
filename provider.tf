terraform {
  required_providers {

    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = ">= 0.16.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }

  }
  required_version = ">= 1.1.0"
}

provider "bitwarden" {}

provider "aws" {
  # Configure your AWS region / credentials as usual (env vars, shared config, etc.)
  region = lookup(var.aws_region, terraform.workspace)
}

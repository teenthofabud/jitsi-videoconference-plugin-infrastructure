terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aiven = {
      source  = "aiven/aiven"
      version = "~> 4.60"
    }
  }

  backend "s3" {}
}

provider "aiven" {}

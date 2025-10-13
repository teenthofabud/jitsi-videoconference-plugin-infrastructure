terraform {
  required_providers {

    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = ">= 0.16.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "bitwarden" {}

project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
use_local_mock         = false
environment            = "dev"
terraform_state_bucket = "toab-jitsi-infrastructure-dev-414772275073-eu-central-1-an"
deployments = {
  eu-central-1 = {

    features = {
      jitsi_web     = true
    }

    jitsi_web = {
      index_document     = "index.html"
      error_document     = "error.html"
      force_destroy      = true
      enable_versioning  = false
      enable_website     = true
      enable_public_read = true
      tags = {
        Component = "jitsi-web-dev"
      }
    }
  }
}
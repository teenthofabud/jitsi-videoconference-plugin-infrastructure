project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
use_local_mock         = false
environment            = "live"
terraform_state_bucket = "toab-jitsi-infrastructure-live-414772275073-eu-central-1-an"
deployments = {
  eu-central-1 = {

    features = {
      jitsi_web     = true
    }

    jitsi_web = {
      index_document     = "index.html"
      error_document     = "error.html"
      force_destroy      = false
      enable_versioning  = true
      enable_website     = true
      enable_public_read = false
      tags = {
        Component = "jitsi-web-live"
      }
    }

  }

}
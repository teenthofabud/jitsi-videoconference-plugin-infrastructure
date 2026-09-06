data "terraform_remote_state" "aws" {
  backend = "s3"

  config = {
    bucket       = var.terraform_state_bucket
    key          = "tfstate/aws-frontend.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}

locals {

  static_web_endpoint          = data.terraform_remote_state.aws.outputs.static_web_endpoint
  api_endpoint                 = data.terraform_remote_state.aws.outputs.jitsi_backend_moderator_function_url
  cdn_config                   = var.config.cdn
  domain_name                  = var.config.domain_name
  page_rule_force_https_target = "http://${var.config.cdn.website_dns_record_name}.${local.domain_name}/*"

  context = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region

    common_tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }

}

data "terraform_remote_state" "aws" {
  backend = "s3"

  config = {
    bucket       = var.terraform_state_bucket
    key          = "tfstate/aws.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}

locals {

  static_web_endpoint          = data.terraform_remote_state.aws.outputs.static_web_endpoint
  cloudflare_config            = var.config
  cdn_config                   = local.cloudflare_config.cdn
  rate_limit_config            = local.cloudflare_config.rate_limit
  domain_name                  = local.cloudflare_config.domain_name
  # page_rule_force_https_target = "http://example.com/*"
  page_rule_cache_all_target   = "*.${local.domain_name}/*"

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

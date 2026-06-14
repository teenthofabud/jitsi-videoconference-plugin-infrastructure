locals {
  deployment_config = var.deployments[var.aws_region]
  features          = local.deployment_config.features

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


  # Cloudflare
  cloudflare_config            = local.deployment_config.cloudflare
  cdn_config                   = local.cloudflare_config.cdn
  rate_limit_config            = local.cloudflare_config.rate_limit
  dns_record_name              = local.cdn_config.dns_record_name
  domain_name                  = local.cloudflare_config.domain_name
  fqdn                         = local.dns_record_name == "@" || local.dns_record_name == "" ? local.domain_name : "${local.dns_record_name}.${local.domain_name}"
  page_rule_force_https_target = "http://${local.fqdn}/*"
  page_rule_cache_all_target   = "${local.fqdn}/*"

}
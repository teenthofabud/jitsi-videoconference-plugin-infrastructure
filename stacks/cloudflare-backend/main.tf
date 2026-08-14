module "cloudflare_backend" {

  source = "./modules/cloudflare"

  # CDN
  domain_name               = var.config.domain_name
  api_endpoint              = local.api_endpoint
  api_dns_record_name       = var.config.cdn.api_dns_record_name
  dns_record_type           = var.config.cdn.dns_record_type
  cloudflare_record_proxied = var.config.cdn.cloudflare_record_proxied
  cloudflare_record_ttl     = var.config.cdn.cloudflare_record_ttl
  # Page rule: force HTTPS
  page_rule_force_https_target   = local.page_rule_force_https_target
  page_rule_force_https_priority = var.config.cdn.page_rule_force_https_priority

  # Rate limiting
  rate_limit_period              = local.rate_limit_config.period
  rate_limit_mitigation_timeout  = local.rate_limit_config.mitigation_timeout
  rate_limit_requests_per_period = local.rate_limit_config.requests_per_period

}



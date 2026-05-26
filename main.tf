module "jitsi_web" {
  count  = local.features.jitsi_web ? 1 : 0
  source = "./components/jitsi-web"

  context = local.context
  config  = local.deployment_config.jitsi_web
}

module "jitsi_vpc" {
  count  = local.features.jitsi_vpc ? 1 : 0
  source = "./components/jitsi-vpc"

  context = local.context
  config  = local.deployment_config.jitsi_vpc
}

module "cloudflare" {
  count  = local.features.cloudflare && local.features.jitsi_web ? 1 : 0
  source = "./modules/cloudflare"

  static_website_endpoint = module.jitsi_web[0].static_web_endpoint

  # CDN / DNS
  domain_name                = local.deployment_config.cloudflare.domain_name
  dns_record_name            = local.deployment_config.cloudflare.cdn.dns_record_name
  dns_record_type            = local.deployment_config.cloudflare.cdn.dns_record_type
  cloudflare_record_proxied  = local.deployment_config.cloudflare.cdn.cloudflare_record_proxied
  cloudflare_record_ttl      = local.deployment_config.cloudflare.cdn.cloudflare_record_ttl

  # Page rule: force HTTPS
  page_rule_force_https_target   = local.deployment_config.cloudflare.cdn.page_rule_force_https_target
  page_rule_force_https_priority = local.deployment_config.cloudflare.cdn.page_rule_force_https_priority

  # Page rule: cache everything
  page_rule_cache_all_target         = local.deployment_config.cloudflare.cdn.page_rule_cache_all_target
  page_rule_cache_all_cache_level    = local.deployment_config.cloudflare.cdn.page_rule_cache_all_cache_level
  page_rule_cache_all_edge_cache_ttl = local.deployment_config.cloudflare.cdn.page_rule_cache_all_edge_cache_ttl
  page_rule_cache_all_priority       = local.deployment_config.cloudflare.cdn.page_rule_cache_all_priority

  # Unauthorized ports
  allowed_ports = local.deployment_config.cloudflare.unauthorized_port.allowed_ports

  # Geo block
  block_locations = local.deployment_config.cloudflare.geo_block.block_locations
}

module "cloudflare_common" {

  source = "./modules/cloudflare/common"

  # CDN / DNS
  domain_name               = local.cloudflare_config.domain_name
  # Page rule: force HTTPS
  # page_rule_force_https_target   = local.page_rule_force_https_target
  # page_rule_force_https_priority = local.cdn_config.page_rule_force_https_priority

  # Page rule: cache everything
  enable_cache_page_rule             = local.cdn_config.enable_cache_page_rule
  page_rule_cache_all_target         = local.page_rule_cache_all_target
  page_rule_cache_all_cache_level    = local.cdn_config.page_rule_cache_all_cache_level
  page_rule_cache_all_edge_cache_ttl = local.cdn_config.page_rule_cache_all_edge_cache_ttl
  page_rule_cache_all_priority       = local.cdn_config.page_rule_cache_all_priority

  # Unauthorized ports
  allowed_ports = local.cloudflare_config.unauthorized_port.allowed_ports

  # Geo block
  block_locations = local.cloudflare_config.geo_block.block_locations

  # Rate limiting
  rate_limit_period              = local.rate_limit_config.period
  rate_limit_mitigation_timeout  = local.rate_limit_config.mitigation_timeout
  rate_limit_requests_per_period = local.rate_limit_config.requests_per_period

  # Worker
  static_website_endpoint   = local.static_web_endpoint
  proxy_worker_name                  = local.cloudflare_config.worker.proxy_worker_name
  proxy_worker_module_name           = "proxy_worker.js"
  proxy_worker_path                  = "${path.module}/scripts/proxy_worker.js"
  incoming_request_pattern_for_proxy = local.cloudflare_config.worker.incoming_request_pattern_for_proxy

}

module "api_dns"{
  source = "./modules/cloudflare/api-dns"
  api_endpoint              = local.api_endpoint
  domain_name               = local.cloudflare_config.domain_name
  api_dns_record_name       = local.cdn_config.api_dns_record_name
  dns_record_type           = local.cdn_config.dns_record_type
  cloudflare_record_proxied = local.cdn_config.cloudflare_record_proxied
  cloudflare_record_ttl     = local.cdn_config.cloudflare_record_ttl
}


module  "website_dns" {
  source = "./modules/cloudflare/website-dns"
  static_website_endpoint   = local.static_web_endpoint
  domain_name               = local.cloudflare_config.domain_name
  website_dns_record_name   = local.cdn_config.website_dns_record_name
  dns_record_type           = local.cdn_config.dns_record_type
  cloudflare_record_proxied = local.cdn_config.cloudflare_record_proxied
  cloudflare_record_ttl     = local.cdn_config.cloudflare_record_ttl

}

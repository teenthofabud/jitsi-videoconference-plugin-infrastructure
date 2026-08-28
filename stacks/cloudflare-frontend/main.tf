module "cloudflare_frontend" {

  source = "./modules/cloudflare"

  # CDN / DNS
  domain_name               = local.domain_name
  page_rule_force_https_target   = local.page_rule_force_https_target
  page_rule_force_https_priority = local.cdn_config.page_rule_force_https_priority
  static_website_endpoint   = local.static_web_endpoint

  website_dns_record_name   = local.cdn_config.website_dns_record_name
  dns_record_type           = local.cdn_config.dns_record_type
  cloudflare_record_proxied = local.cdn_config.cloudflare_record_proxied
  cloudflare_record_ttl     = local.cdn_config.cloudflare_record_ttl

  # Geo block
  block_locations = var.config.geo_block.block_locations

  # Worker
  proxy_worker_name                  = var.config.worker.proxy_worker_name
  proxy_worker_module_name           = "proxy_worker_website.js"
  proxy_worker_path                  = "${path.module}/scripts/proxy_worker_website.js"
  incoming_request_pattern_for_proxy = var.config.worker.incoming_request_pattern_for_proxy

}



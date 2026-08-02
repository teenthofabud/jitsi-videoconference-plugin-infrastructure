
resource "cloudflare_dns_record" "website_s3_cname" {
  zone_id = local.zone_id
  name    = var.website_dns_record_name
  content = var.static_website_endpoint
  type    = var.dns_record_type
  proxied = var.cloudflare_record_proxied
  ttl     = var.cloudflare_record_ttl
}

resource "cloudflare_dns_record" "api_lambda_cname" {
  zone_id = local.zone_id
  name    = var.api_dns_record_name
  content = var.static_website_endpoint
  type    = var.dns_record_type
  proxied = var.cloudflare_record_proxied
  ttl     = var.cloudflare_record_ttl
}

# resource "cloudflare_page_rule" "force_https" {
#   zone_id = local.zone_id
#   target  = var.page_rule_force_https_target #"http://www.yourdomain.com/*"
#   actions = {
#     always_use_https = true
#   }
#   priority = var.page_rule_force_https_priority
# }

resource "cloudflare_zone_setting" "always_use_https" {
  zone_id    = local.zone_id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_page_rule" "cache_all" {
  count = var.enable_cache_page_rule ? 1 : 0

  zone_id = data.cloudflare_zone.domain.id
  target  = var.page_rule_cache_all_target #"www.yourdomain.com/*"
  actions = {
    cache_level    = var.page_rule_cache_all_cache_level    #"Cache Everything" 
    edge_cache_ttl = var.page_rule_cache_all_edge_cache_ttl #2419200 (4 weeks) 
  }
  priority = var.page_rule_cache_all_priority #2
}
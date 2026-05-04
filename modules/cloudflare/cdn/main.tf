data "cloudflare_zone" "domain" {
  name = "yourdomain.com" #var.domain_name
}

resource "cloudflare_record" "s3_cname" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "www" #var.dns_record_name
  value   = aws_s3_bucket.static_site.website_endpoint
  type    = "CNAME" #var.dns_record_type
  proxied = true    #var.cloudflare_record_proxied
  ttl     = 1       #var.cloudflare_record_ttl
}

resource "cloudflare_page_rule" "force_https" {
  zone_id = data.cloudflare_zone.domain.id
  target  = "http://www.yourdomain.com/*" #var.page_rule_force_https_target
  actions = {
    always_use_https = true
  }
  priority = 1 #var.page_rule_force_https_priority
}

resource "cloudflare_page_rule" "cache_all" {
  zone_id = data.cloudflare_zone.domain.id
  target  = "www.yourdomain.com/*" #var.page_rule_cache_all_target
  actions = {
    cache_level    = "Cache Everything" #var.page_rule_cache_all_cache_level
    edge_cache_ttl = 31536000           # 1 year; var.page_rule_cache_all_edge_cache_ttl
  }
  priority = 2 #var.page_rule_cache_all_priority
}
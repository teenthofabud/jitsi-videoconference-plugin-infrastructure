
resource "cloudflare_page_rule" "force_https" {
  zone_id = local.zone_id
  target  = var.page_rule_force_https_target #"http://www.yourdomain.com/*"
  actions = {
    always_use_https = true
  }
  priority = var.page_rule_force_https_priority
}

resource "cloudflare_dns_record" "api_lambda_cname" {
  zone_id = local.zone_id
  name    = var.api_dns_record_name
  content = trimsuffix(trimprefix(var.api_endpoint, "https://"), "/")
  type    = var.dns_record_type
  proxied = var.cloudflare_record_proxied
  ttl     = var.cloudflare_record_ttl
}

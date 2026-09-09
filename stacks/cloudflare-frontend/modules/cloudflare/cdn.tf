
resource "cloudflare_page_rule" "force_https" {
  zone_id = local.zone_id
  target  = var.page_rule_force_https_target #"http://www.yourdomain.com/*"
  actions = {
    always_use_https = true
  }
  priority = var.page_rule_force_https_priority
}


resource "cloudflare_dns_record" "apex_cname" {
  zone_id = local.zone_id
  name    = var.website_dns_record_name
  content = var.static_website_endpoint
  type    = var.dns_record_type
  proxied = var.cloudflare_record_proxied
  ttl     = var.cloudflare_record_ttl
}

resource "cloudflare_dns_record" "www_cname" {
  zone_id = local.zone_id
  name    = "www"
  # Point www to your apex domain so Cloudflare's proxy catches it
  content = var.domain_name 
  type    = "CNAME"
  proxied = true # Must be orange-clouded for the redirect rule to trigger!
  ttl     = 1
}

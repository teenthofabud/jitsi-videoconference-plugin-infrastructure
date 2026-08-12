data "cloudflare_zone" "domain" {
  filter = {
    name = var.domain_name
  }
}

locals {
  zone_id    = data.cloudflare_zone.domain.id
  account_id = data.cloudflare_zone.domain.account.id
}


resource "cloudflare_dns_record" "api_lambda_cname" {
  zone_id = local.zone_id
  name    = var.api_dns_record_name
  content = var.api_endpoint
  type    = var.dns_record_type
  proxied = var.cloudflare_record_proxied
  ttl     = var.cloudflare_record_ttl
}

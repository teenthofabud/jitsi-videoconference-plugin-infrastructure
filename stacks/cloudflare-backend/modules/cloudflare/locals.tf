data "cloudflare_zone" "domain" {
  filter = {
    name = var.domain_name
  }
}

locals {
  zone_id    = data.cloudflare_zone.domain.id
  account_id = data.cloudflare_zone.domain.account.id
}
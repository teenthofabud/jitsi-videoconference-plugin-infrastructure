data "cloudflare_zone" "domain" {
  name = var.domain_name
}

locals {
  zone_id = data.cloudflare_zone.domain.id
}
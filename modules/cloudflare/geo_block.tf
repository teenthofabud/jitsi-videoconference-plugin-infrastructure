resource "cloudflare_ruleset" "geo_block" {
  zone_id = local.zone_id
  name    = "Block traffic from selected countries"
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  rules = [
    {
      action = "block"
      # join() will produce something like \"RU\" \"CN\" \"KP\"
      expression  = "(ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.block_locations))}})" #"(ip.geoip.country in {\"RU\" \"CN\" \"KP\"})"
      description = "Block traffic from Russia, China, North Korea"
      enabled     = true
    }
  ]
}

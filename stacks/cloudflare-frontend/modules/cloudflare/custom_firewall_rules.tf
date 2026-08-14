
resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = local.zone_id
  name        = "Custom firewall rules for Jitsi zone"
  description = "Blocks unauthorized ports and selected countries."
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [
    {
      ref         = "geo_block_selected_countries"
      description = "Block traffic from selected countries."
      # join() will produce something like \"RU\" \"CN\" \"KP\"
      expression = "(ip.geoip.country in {${join(" ", formatlist("\"%s\"", var.block_locations))}})"
      action     = "block"
      enabled    = true
    }
  ]
}

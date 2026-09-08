
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

resource "cloudflare_ruleset" "www_to_apex_redirect" {
  count = var.enable_redirect_to_www ? 1 : 0
  zone_id     = local.zone_id
  name        = "Default Redirects"
  description = "Redirect rules for the zone"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules = [
    {
      description = "Redirect www to apex domain"
      expression  = "(http.host eq \"www.${var.domain_name}\")"
      action      = "redirect"
      enabled     = true

      action_parameters = {
        from_value = {
          status_code           = 301
          preserve_query_string = true 
          target_url = {
            expression = "concat(\"https://${var.domain_name}\", http.request.uri.path)"
          }
        }
      }
    }
  ]
}

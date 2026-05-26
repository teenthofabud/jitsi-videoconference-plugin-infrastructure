resource "cloudflare_ruleset" "zone_custom_firewall" {
  zone_id     = local.zone_id
  name        = "Phase entry point ruleset for custom rules in my zone"
  description = "block unauthorized ports"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [
    {
      ref         = "block_non_default_ports"
      description = "Block ports other than 80 and 443"
      # join() will produce something like "80 443"
      expression = "(not cf.edge.server_port in {${join(" ", var.allowed_ports)}})" #"(not cf.edge.server_port in {80 443})"
      action     = "block"
      enabled    = true
    }
  ]
}
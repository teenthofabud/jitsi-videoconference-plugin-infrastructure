resource "cloudflare_ruleset" "zone_rl" {
  zone_id     = local.zone_id
  name        = "Rate limiting for my zone"
  description = ""
  kind        = "zone"
  phase       = "http_ratelimit"

  rules = [
    {
      ref         = "rate_limit_api_requests_ip"
      description = "Rate limit API requests by IP"
      # expression  = "(http.request.uri.path matches \"^/api/\")"
      expression = true
      action      = "block"
      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 60
        requests_per_period = 100
        mitigation_timeout  = 600
      }
    }
  ]
}
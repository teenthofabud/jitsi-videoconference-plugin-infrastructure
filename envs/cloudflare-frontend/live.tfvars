project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
environment            = "live"
terraform_state_bucket = "toab-jitsi-infrastructure-live-414772275073-eu-central-1-an"
config = {
  domain_name = "toab-jitsi.com"
  cdn = {
    website_dns_record_name            = "@"
    enable_redirect_to_www             = true
    dns_record_type                    = "CNAME"
    cloudflare_record_proxied          = true
    cloudflare_record_ttl              = 1
    page_rule_force_https_priority     = 1
  }

   geo_block = {
    block_locations = ["RU", "CN", "KP"]
  }

  worker = {
    proxy_worker_name                  = "proxy-worker-website-live"
    incoming_request_patterns_for_proxy = ["toab-jitsi.com/*"]
  }
}
    
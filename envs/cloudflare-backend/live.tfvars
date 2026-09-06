project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
environment            = "live"
terraform_state_bucket = "toab-jitsi-infrastructure-live-414772275073-eu-central-1-an"
config = {
  domain_name = "toab-jitsi.com"
  cdn = {
    api_dns_record_name                = "api"
    dns_record_type                    = "CNAME"
    cloudflare_record_proxied          = true
    cloudflare_record_ttl              = 1
    page_rule_force_https_priority     = 1
  }

  rate_limit = {
    period              = 10
    requests_per_period = 100 
    mitigation_timeout  = 10
  }

  worker = {
    proxy_worker_name                  = "proxy-worker-backend-live"
    incoming_request_pattern_for_proxy = "api.toab-jitsi.com/*"
  }
}
    
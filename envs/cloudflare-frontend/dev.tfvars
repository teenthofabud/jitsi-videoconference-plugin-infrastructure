project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
environment            = "dev"
terraform_state_bucket = "toab-jitsi-infrastructure-dev-414772275073-eu-central-1-an"
config = {
  domain_name = "jitsi.dpdns.org"
  cdn = {
    website_dns_record_name            = "www"
    dns_record_type                    = "CNAME"
    cloudflare_record_proxied          = true
    cloudflare_record_ttl              = 1
    page_rule_force_https_priority     = 1
  }

   geo_block = {
    block_locations = ["RU", "CN", "KP"]
  }
  
  worker = {
    proxy_worker_name                  = "proxy-worker-website"
    incoming_request_pattern_for_proxy = "www.jitsi.dpdns.org/*"
  }
}
project_name = "toab-jitsi"
aws_region   = "eu-central-1"
environment = "prod"
terraform_state_bucket = "toab-jitsi-infrastructure-prod-414772275073-eu-central-1-an"
config = {
    domain_name = "example.com"
    cdn = {
      dns_record_name            = "www"
      dns_record_type            = "CNAME"
      cloudflare_record_proxied  = true
      cloudflare_record_ttl      = 1
      enable_cache_page_rule     = false
      page_rule_force_https_priority = 1
      page_rule_cache_all_cache_level    = "cache_everything"
      page_rule_cache_all_edge_cache_ttl = 2419200,
      page_rule_cache_all_priority       = 2
    }
    
    rate_limit = {
      period = 60
      requests_per_period = 100
      mitigation_timeout = 60
    }

    unauthorized_port = {
      allowed_ports = [80, 443]
    }

    geo_block = {
      block_locations = ["RU", "CN", "KP"]
    }

    worker = {
      proxy_worker_name = "proxy-worker"
      incoming_request_pattern_for_proxy = "todo/*"
    }
}
    
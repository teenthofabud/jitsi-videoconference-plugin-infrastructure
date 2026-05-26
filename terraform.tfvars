project_name = "jitsi"
environment  = "dev"
aws_region   = "us-east-1"
use_local_mock = true
deployments = {
  dev = {
    us-east-1 = {
      features = {
        jitsi_web       = true
        jitsi_vpc       = false
        cloudflare      = true
      }

      jitsi_web = {
        index_document        = "index.html"
        error_document        = "error.html"
        force_destroy         = true
        enable_versioning     = false
        enable_website        = true
        enable_public_read    = true
        tags = {
          Component = "jitsi-web"
        }
      }

      jitsi_vpc = {
        vpc = {
          cidr = "10.0.0.0/16"
          tags  = {
            Component = "jitsi-prod-vpc"
          }
        }

        subnet = {
          cidr = "10.0.1.0/24"
          tags = {
            Component = "jitsi-subnet"
          }
        }

        gateway_endpoint = {
          service_name    = "s3"
          route_table_ids = []
          tags = {
            Component = "jitsi-gateway-endpoint"
          }
        }
      }

      cloudflare = {
        domain_name = "example.com"
        cdn = {
          dns_record_name            = "www"
          dns_record_type            = "CNAME"
          cloudflare_record_proxied  = true
          cloudflare_record_ttl      = 1
          page_rule_force_https_target   = "http://www.example.com/*"
          page_rule_force_https_priority = 1
          page_rule_cache_all_target         = "www.example.com/*"
          page_rule_cache_all_cache_level    = "cache_everything"
          page_rule_cache_all_edge_cache_ttl = 31536000
          page_rule_cache_all_priority       = 2
        }

        unauthorized_port = {
          allowed_ports = [80, 443]
        }

        geo_block = {
          block_locations = ["RU", "CN", "KP"]
        }
      }
    }
  }

  prod = {
    us-east-1 = {
      features = {
        jitsi_web       = true
        jitsi_vpc       = true
        cloudflare      = true
      }

      jitsi_web = {
        index_document        = "index.html"
        error_document        = "error.html"
        force_destroy         = false
        enable_versioning     = true
        enable_website        = true
        enable_public_read    = false
        tags = {
          Component = "jitsi-web"
        }
      }

      jitsi_vpc = {
        vpc = {
          cidr = "10.0.0.0/16"
          tags  = {
            Component = "jitsi-prod-vpc"
          }
        }

        subnet = {
          cidr = "10.0.1.0/24"
          tags = {
            Component = "jitsi-subnet"
          }
        }

        gateway_endpoint = {
          service_name    = "s3"
          route_table_ids = []
          tags = {
            Component = "jitsi-gateway-endpoint"
          }
        }
      }


      cloudflare = {
        domain_name = "example.com"
        cdn = {
          dns_record_name            = "www"
          dns_record_type            = "CNAME"
          cloudflare_record_proxied  = true
          cloudflare_record_ttl      = 1
          page_rule_force_https_target   = "http://www.example.com/*"
          page_rule_force_https_priority = 1
          page_rule_cache_all_target         = "www.example.com/*"
          page_rule_cache_all_cache_level    = "cache_everything"
          page_rule_cache_all_edge_cache_ttl = 31536000
          page_rule_cache_all_priority       = 2
        }

        unauthorized_port = {
          allowed_ports = [80, 443]
        }

        geo_block = {
          block_locations = ["RU", "CN", "KP"]
        }
      }
    }
  }
}

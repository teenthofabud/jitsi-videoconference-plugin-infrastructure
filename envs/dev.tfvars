project_name = "toab-jitsi"
aws_region   = "eu-central-1"
use_local_mock = true
environment = "dev"
deployments =  {
    eu-central-1 = {

      features = {
        jitsi_web       = true
        jitsi_vpc       = false
        cloudflare      = true
        jitsi_iam       = true
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
            Component = "jitsi-dev-vpc"
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
        domain_name = "shahad42069.dpdns.org"
        cdn = {
          dns_record_name            = "www"
          dns_record_type            = "CNAME"
          cloudflare_record_proxied  = true
          cloudflare_record_ttl      = 1
          page_rule_force_https_priority = 1
          page_rule_cache_all_cache_level    = "cache_everything"
          page_rule_cache_all_edge_cache_ttl = 2419200,
          page_rule_cache_all_priority       = 2
        }

        rate_limit = {
          period = 10
          requests_per_period = 100
          mitigation_timeout = 10
        }

        unauthorized_port = {
          allowed_ports = [80, 443]
        }

        geo_block = {
          block_locations = ["RU", "CN", "KP"]
        }
      }

      jitsi_iam = {
        github_org = "teenthofabud"
        github_repo = "jitsi-videoconference-plugin-app"
        github_branch = "*"
        github_oidc_link            = "https://token.actions.githubusercontent.com"
        oidc_client_id_list         = ["sts.amazonaws.com"]
        gh_actions_s3_deploy_role_name   = "jitsi-github-actions-s3-deploy-role"
        gh_actions_role_policy_name = "jitsi-github-actions-s3-deploy-role-policy"
      }
  }
}
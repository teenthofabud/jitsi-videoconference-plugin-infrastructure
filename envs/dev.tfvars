project_name = "toab-jitsi"
aws_region   = "eu-central-1"
use_local_mock = false
environment = "dev"
deployments =  {
    eu-central-1 = {

      features = {
        jitsi_web       = true
        jitsi_vpc       = false
        cloudflare      = true
        jitsi_iam       = true
        jitsi_rds       = true
      }

      jitsi_web = {
        index_document        = "index.html"
        error_document        = "error.html"
        force_destroy         = true
        enable_versioning     = false
        enable_website        = true
        enable_public_read    = true
        tags = {
          Component = "jitsi-web-dev"
        }
      }

      jitsi_rds = {
        engine_version        = "16.3"
        instance_class        = "db.t4g.micro"
        allocated_storage     = 20
        max_allocated_storage = 50
        storage_type          = "gp2"
        db_name  = "jitsi_access"
        username = "jitsi_admin"
        multi_az                = false
        backup_retention_period = 1 
        backup_window           = "03:00-04:00"
        skip_final_snapshot = true
        deletion_protection = false
        subnet_group = {
          tags = {
            Component = "jitsi-rds-subnet-group-dev"
          }
        }
        tags = {
          Component = "jitsi-rds-postgres-dev"
        }
      }

      jitsi_vpc = {
        vpc = {
          cidr = "10.0.0.0/16"
          tags = {
            Component = "jitsi-vpc-dev"
          }
        }
        private_subnet_a = {
          cidr              = "10.0.1.0/24"
          availability_zone = "eu-central-1a"
          tags = {
            Component = "jitsi-private-subnet-a-dev"
          }
        }
        private_subnet_b = {
          cidr              = "10.0.2.0/24"
          availability_zone = "eu-central-1b"
          tags = {
            Component = "jitsi-private-subnet-b-dev"
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
          enable_cache_page_rule     = false
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

        worker = {
          proxy_worker_name = "proxy-worker"
          incoming_request_pattern_for_proxy = "www.shahad42069.dpdns.org/*"
        }
      }

      jitsi_iam = {
        github_org = "teenthofabud"
        github_repo = "jitsi-videoconference-plugin-app"
        github_branch = "*"
        github_oidc_link            = "https://token.actions.githubusercontent.com"
        oidc_client_id_list         = ["sts.amazonaws.com"]
        gh_actions_s3_deploy_role_name   = "toab-jitsi-github-actions-s3-deploy-role-dev"
        gh_actions_role_policy_name = "toab-jitsi-github-actions-s3-deploy-policy-dev"
      }

  }
}
project_name = "toab-jitsi"
aws_region   = "eu-central-1"
use_local_mock = false
environment = "prod"
deployments = {
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
        force_destroy         = false
        enable_versioning     = true
        enable_website        = true
        enable_public_read    = false
        tags = {
          Component = "jitsi-web-prod"
        }
      }

      jitsi_vpc = {
        vpc = {
          cidr = "10.20.0.0/16"
          tags = {
            Component = "jitsi-vpc-prod"
          }
        }
        private_subnet_a = {
          cidr              = "10.20.1.0/24"
          availability_zone = "eu-central-1a"
          tags = {
            Component = "jitsi-private-subnet-a-prod"
          }
        }
        private_subnet_b = {
          cidr              = "10.20.2.0/24"
          availability_zone = "eu-central-1b"
          tags = {
            Component = "jitsi-private-subnet-b-prod"
          }
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
            Component = "jitsi-rds-subnet-group-prod"
          }
        }
        tags = {
          Component = "jitsi-rds-postgres-prod"
        }
      }

      cloudflare = {
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
      
      jitsi_iam = {
        github_org = "teenthofabud"
        github_repo = "jitsi-videoconference-plugin-app"
        github_branch = "*"
        github_oidc_link            = "https://token.actions.githubusercontent.com"
        oidc_client_id_list         = ["sts.amazonaws.com"]
        gh_actions_s3_deploy_role_name   = "toab-jitsi-github-actions-s3-deploy-role-prod"
        gh_actions_role_policy_name = "toab-jitsi-github-actions-s3-deploy-policy-prod"
      }

      jitsi_lambda = {
        migration_lambda = {
          use_s3_artifact = true
          s3_bucket       = "toab-jitsi-infrastructure-prod-414772275073-eu-central-1"
          s3_key          = "lambda/access-list-migration/prod/contact-migration-lambda-1.0.0.jar"
          handler = "com.toab.jitsi.migration.MigrationHandler::handleRequest"
          runtime = "java21"
          memory_size           = 512
          timeout               = 60
          log_retention_in_days = 7
          environment_variables = {
            LOG_LEVEL = "INFO"
          }
          tags = {
            Component = "jitsi-access-list-migration-lambda-prod"
          }
        }

        backend_lambda = {
          use_s3_artifact = true
          s3_bucket       = "toab-jitsi-infrastructure-prod-414772275073-eu-central-1"
          s3_key          = "lambda/access-list-backend/prod/backend-lambda-1.0.0.jar"
          handler = "com.toab.jitsi.backend.Application::handleRequest"
          runtime = "java21"
          memory_size           = 1024
          timeout               = 30
          log_retention_in_days = 7
          environment_variables = {
            LOG_LEVEL       = "INFO"
            ALLOWED_ORIGIN = "https://www.toab-jitsi.com"
          }
          tags = {
            Component = "jitsi-access-list-backend-lambda-prod"
          }
        }
      }
    }
  
}
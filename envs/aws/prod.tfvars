project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
use_local_mock         = false
environment            = "prod"
terraform_state_bucket = "toab-jitsi-infrastructure-prod-414772275073-eu-central-1-an"
deployments = {
  eu-central-1 = {

    features = {
      jitsi_web     = true
      jitsi_vpc     = false
      jitsi_backend = true
      cloudflare    = true
    }

    jitsi_web = {
      index_document     = "index.html"
      error_document     = "error.html"
      force_destroy      = false
      enable_versioning  = true
      enable_website     = true
      enable_public_read = false
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

      subnet = {
        cidr = "10.20.1.0/24"
        tags = {
          Component = "jitsi-subnet-prod"
        }
      }

      gateway_endpoint = {
        service_name    = "s3"
        route_table_ids = []
        tags = {
          Component = "jitsi-gateway-endpoint-prod"
        }
      }
    }

    jitsi_backend = {
      moderator = {
        function_name         = "toab-jitsi-moderator-service"
        handler               = "bootstrap"
        runtime               = "provided.al2023"
        architectures         = ["x86_64"]
        memory_size           = 256
        timeout               = 300
        log_retention_in_days = 7

        function_url = {
          auth_type         = "NONE"
          invoke_mode       = "BUFFERED"
          allow_credentials = false
          allow_headers     = ["content-type", "authorization"]
          allow_methods     = ["POST"]
          allow_origins     = ["https://www.jitsi.dpdns.org"]
          expose_headers    = []
          max_age           = 300
        }
        tags = {
          Component = "toab-jitsi-moderator-service-lambda-prod"
        }
      }

      db_ping = {
        function_name         = "toab-aiven-service-ping-prod"
        handler               = "bootstrap"
        runtime               = "provided.al2023"
        architectures         = ["x86_64"]
        memory_size           = 128
        timeout               = 200
        log_retention_in_days = 7

        schedule = {
          expression                   = "rate(30 minutes)"
          timezone                     = "UTC"
          state                        = "ENABLED"
          input                        = "{}"
          maximum_event_age_in_seconds = 3600
          maximum_retry_attempts       = 0
        }

        spring_config = {
          hikari_max_pool_size = 2
          hikari_min_idle_count = 1
        }
        
        tags = {
          Component = "toab-aiven-service-ping-lambda-prod"
        }
      }

      auth0 = {
        api_identifier = "toab-jitsi"
        domain = "teenthofabud-prod.eu.auth0.com"
      }
    }

  }

}
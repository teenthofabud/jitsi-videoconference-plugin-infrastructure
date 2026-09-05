project_name           = "toab-jitsi"
aws_region             = "eu-central-1"
use_local_mock         = false
environment            = "dev"
terraform_state_bucket = "toab-jitsi-infrastructure-dev-414772275073-eu-central-1-an"
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
      force_destroy      = true
      enable_versioning  = false
      enable_website     = true
      enable_public_read = true
      tags = {
        Component = "jitsi-web-dev"
      }
    }

    jitsi_vpc = {
      vpc = {
        cidr = "10.0.0.0/16"
        tags = {
          Component = "jitsi-vpc-dev"
        }
      }

      subnet = {
        cidr = "10.0.1.0/24"
        tags = {
          Component = "jitsi-subnet-dev"
        }
      }

      gateway_endpoint = {
        service_name    = "s3"
        route_table_ids = []
        tags = {
          Component = "jitsi-gateway-endpoint-dev"
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

        spring_config = {
          hikari_max_pool_size = 2
          hikari_min_idle_count = 1
        }

        tags = {
          Component = "toab-jitsi-moderator-service-lambda-dev"
        }
      }

      db_ping = {
        enable_db_ping        = true
        function_name         = "toab-aiven-service-ping"
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
        tags = {
          Component = "toab-aiven-service-ping-lambda-dev"
        }
      }

      auth0 = {
        api_identifier = "toab-jitsi"
        domain = "teenthofabud-dev.eu.auth0.com"
      }
    }

  }
}
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

      jitsi_vpc = {
        vpc = {
          cidr = "10.0.0.0/16"
          tags  = {
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

  }
}
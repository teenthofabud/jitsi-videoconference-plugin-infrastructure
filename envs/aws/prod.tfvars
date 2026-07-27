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
          tags  = {
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
      
      
      jitsi_iam = {
        gh_actions_s3_deploy_role_name   = "toab-jitsi-github-actions-s3-deploy-role-prod"
        gh_actions_role_policy_name = "toab-jitsi-github-actions-s3-deploy-policy-prod"
      }
    }
  
}
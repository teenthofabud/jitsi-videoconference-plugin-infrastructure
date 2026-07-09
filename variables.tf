variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
}

variable "use_local_mock" {
  description = "Whether to locally mock aws using floci"
  type        = bool
}

variable "deployments" {
  description = "Environment and region specific deployment configuration."

  type = map(object({
    features = object({
      jitsi_web  = bool
      jitsi_vpc  = bool
      cloudflare = bool
      jitsi_iam  = bool
      jitsi_rds  = bool
    })

    jitsi_web = optional(object({
      index_document     = string
      error_document     = string
      force_destroy      = bool
      enable_versioning  = bool
      enable_website     = bool
      enable_public_read = bool
      tags               = map(string)
    }))

    jitsi_vpc = optional(object({
      vpc = object({
        cidr = string
        tags = optional(map(string), {})
      })

      private_subnet_a = object({
        cidr              = string
        availability_zone = string
        tags              = optional(map(string), {})
      })

      private_subnet_b = object({
        cidr              = string
        availability_zone = string
        tags              = optional(map(string), {})
      })
    }))

    jitsi_rds = optional(object({
      engine_version        = optional(string, "16.3")
      instance_class        = optional(string, "db.t4g.micro")
      allocated_storage     = optional(number, 20)
      max_allocated_storage = optional(number, 50)
      storage_type          = optional(string, "gp2")
      db_name  = string
      username = string
      multi_az                = optional(bool, false)
      backup_retention_period = optional(number, 1)
      backup_window           = optional(string, "03:00-04:00")
      skip_final_snapshot = optional(bool, true)
      deletion_protection = optional(bool, false)
      subnet_group = object({
        tags = optional(map(string), {})
      })
      tags = optional(map(string), {})
    }))

    cloudflare = optional(object({
      domain_name = string

      cdn = object({
        dns_record_name                    = optional(string, "www")
        dns_record_type                    = optional(string, "CNAME")
        cloudflare_record_proxied          = optional(bool, true)
        cloudflare_record_ttl              = optional(number, 1)
        enable_cache_page_rule             = optional(bool,false)
        page_rule_force_https_priority     = optional(number, 1)
        page_rule_cache_all_cache_level    = string
        page_rule_cache_all_edge_cache_ttl = optional(number, 31536000)
        page_rule_cache_all_priority       = optional(number, 2)
      })

      rate_limit = object({
        period              = optional(number, 60)
        requests_per_period = optional(number, 100)
        mitigation_timeout  = optional(number, 60)
      })

      unauthorized_port = object({
        allowed_ports = optional(list(number), [80, 443])
      })

      geo_block = object({
        block_locations = optional(list(string), ["RU", "CN", "KP"])
      })

      worker = object({
        proxy_worker_name = string
        incoming_request_pattern_for_proxy = string
      })
    }))

    jitsi_iam = optional(object({
      github_org                     = string
      github_repo                    = string
      github_branch                  = string
      github_oidc_link               = string
      oidc_client_id_list            = list(string)
      gh_actions_s3_deploy_role_name = string
      gh_actions_role_policy_name    = string
    }))

  }))
}
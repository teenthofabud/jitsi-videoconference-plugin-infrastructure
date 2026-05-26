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

  type = map(map(object({
    features = object({
      jitsi_web       = bool
      jitsi_vpc       = bool
      cloudflare      = bool
    })

    jitsi_web = optional(object({
      index_document         = string
      error_document         = string
      force_destroy          = bool
      enable_versioning      = bool
      enable_website         = bool
      enable_public_read     = bool
      tags                   = map(string)
    }))

    jitsi_vpc = optional(object({
      vpc = object({
        cidr = string
        tags  = map(string)
      })

      subnet = object({
        cidr = string
        tags = map(string)
      })

      gateway_endpoint = object({
        service_name    = string
        route_table_ids = list(string)
        tags            = map(string)
      })
    }))

    cloudflare = optional(object({
      domain_name = string

      cdn = object({
        dns_record_name              = optional(string, "www")
        dns_record_type              = optional(string, "CNAME")
        cloudflare_record_proxied    = optional(bool, true)
        cloudflare_record_ttl        = optional(number, 1)

        page_rule_force_https_target   = string
        page_rule_force_https_priority = optional(number, 1)

        page_rule_cache_all_target         = string
        page_rule_cache_all_cache_level    = string
        page_rule_cache_all_edge_cache_ttl = optional(number, 31536000)
        page_rule_cache_all_priority       = optional(number, 2)
      })

      unauthorized_port = object({
        allowed_ports = optional(list(number), [80, 443])
      })

      geo_block = object({
        block_locations = optional(list(string), ["RU", "CN", "KP"])
      })
    }))

  })))
}
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

variable "terraform_state_bucket" {
  description = "tfstate bucket name of the AWS stack"
  type        = string
}

variable "config" {
  description = "Cloudflare configuration"
  type = object({
    domain_name = string

    cdn = object({
      dns_record_name                    = optional(string, "www")
      dns_record_type                    = optional(string, "CNAME")
      enable_cache_page_rule             = optional(bool, false)
      cloudflare_record_proxied          = optional(bool, true)
      cloudflare_record_ttl              = optional(number, 1)
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
      proxy_worker_name                  = string
      incoming_request_pattern_for_proxy = string
    })
  })

}
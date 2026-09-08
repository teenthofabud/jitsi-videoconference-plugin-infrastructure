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
      website_dns_record_name            = optional(string, "api")
      enable_redirect_to_www             = true
      dns_record_type                    = optional(string, "CNAME")
      cloudflare_record_proxied          = optional(bool, true)
      cloudflare_record_ttl              = optional(number, 1)
      page_rule_force_https_priority     = optional(number, 1)
    })
    
    geo_block = object({
      block_locations = optional(list(string), ["RU", "CN", "KP"])
    })

    worker = object({
      proxy_worker_name                  = string
      incoming_request_patterns_for_proxy = set(string)
    })
  })

}
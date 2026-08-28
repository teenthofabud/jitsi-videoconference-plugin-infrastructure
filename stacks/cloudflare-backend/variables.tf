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
      api_dns_record_name                    = optional(string, "api")
      dns_record_type                    = optional(string, "CNAME")
      cloudflare_record_proxied          = optional(bool, true)
      cloudflare_record_ttl              = optional(number, 1)
      page_rule_force_https_priority     = optional(number, 1)
    })

    rate_limit = object({
      period              = optional(number, 60)
      requests_per_period = optional(number, 100)
      mitigation_timeout  = optional(number, 60)
    })

    worker = object({
      proxy_worker_name                  = string
      incoming_request_pattern_for_proxy = string
    })
  })

}
variable "context" {
  description = "Common deployment context shared by all Jitsi components."
  type = object({
    project_name = string
    environment  = string
    aws_region   = string
    common_tags  = map(string)
  })
}

variable "config" {
    description = "Cloudflare configuration"
    type = object({
      domain_name = string

      cdn = object({
        dns_record_name                    = optional(string, "www")
        dns_record_type                    = optional(string, "CNAME")
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
        proxy_worker_name = string
        incoming_request_pattern_for_proxy = string
      })
    })

}

variable "static_web_endpoint" {
  description = "Jitsi s3 bucket website endpoint"
  type = string
}
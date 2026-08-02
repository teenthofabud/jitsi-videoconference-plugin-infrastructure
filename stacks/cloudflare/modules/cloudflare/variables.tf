## cdn
variable "domain_name" {
  description = "The domain name to be used with Cloudflare."
  type        = string
}

variable "static_website_endpoint" {
  description = "s3 static website endpoint"
  type        = string
}

variable "dns_record_name" {
  description = "The name of the DNS record to create (e.g., www)."
  type        = string
  default     = "www"
}

variable "dns_record_type" {
  description = "The type of DNS record to create (e.g., A, CNAME)."
  type        = string
  default     = "CNAME"
}

variable "cloudflare_record_proxied" {
  description = "A boolean that indicates whether the record is receiving the performance and security benefits of Cloudflare."
  type        = bool
  default     = true
}

variable "cloudflare_record_ttl" {
  description = "The TTL (time to live) for the DNS record."
  type        = number
  default     = 1
}

variable "page_rule_force_https_target" {
  description = "The target URL pattern for the force HTTPS page rule."
  type        = string
}

variable "page_rule_force_https_priority" {
  description = "The priority of the force HTTPS page rule."
  type        = number
  default     = 1
}

variable "page_rule_cache_all_target" {
  description = "The target URL pattern for the cache all page rule."
  type        = string
}

variable "page_rule_cache_all_cache_level" {
  description = "The cache level for the cache all page rule."
  type        = string
}

variable "page_rule_cache_all_edge_cache_ttl" {
  description = "The edge cache TTL for the cache all page rule."
  type        = number
  default     = 2419200 #4 weeks
}

variable "page_rule_cache_all_priority" {
  description = "The priority of the cache all page rule."
  type        = number
  default     = 2
}


variable "enable_cache_page_rule" {
  description = "Whether to create the Cloudflare cache-all page rule."
  type        = bool
  default     = false
}

## unauthorized_port
variable "allowed_ports" {
  type    = list(number)
  default = [80, 443]
}

## geo_block
variable "block_locations" {
  type    = list(string)
  default = ["RU", "CN", "KP"]
}

## rate_limit
variable "rate_limit_period" {
  description = "Time window in seconds for Cloudflare rate limiting."
  type        = number
  default     = 60
}

variable "rate_limit_requests_per_period" {
  description = "Number of requests allowed during the rate limit period."
  type        = number
  default     = 100
}

variable "rate_limit_mitigation_timeout" {
  description = "Duration in seconds to apply mitigation after the rate limit is exceeded."
  type        = number
  default     = 60
}

## Cloudflare worker
variable "proxy_worker_name" {
  description = "Name for the cloudflare woker"
  type        = string
}

variable "proxy_worker_module_name" {
  description = "Name of the module which exports the fetch method in the worker script"
  type        = string
}

variable "proxy_worker_path" {
  description = "Path to the script for the cloudflare worker"
  type        = string
}

variable "incoming_request_pattern_for_proxy" {
  description = "Pattern to match the incoming requests against"
  type        = string
}
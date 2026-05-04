variable "domain_name" {
  description = "The domain name to be used with Cloudflare."
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
  default     = 31536000
}

variable "page_rule_cache_all_priority" {
  description = "The priority of the cache all page rule."
  type        = number
  default     = 2
}
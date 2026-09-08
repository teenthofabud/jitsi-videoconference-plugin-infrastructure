## CDN

variable "domain_name" {
  description = "The domain name to be used with Cloudflare."
  type        = string
}

variable "static_website_endpoint" {
  description = "s3 static website endpoint"
  type        = string
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

variable "website_dns_record_name" {
  description = "The name of the DNS record to create for the static website"
  type        = string
  default     = "api"
}

variable "enable_redirect_to_www" {
  description = "Whether to enable redirect to www subdomain"
  type        = bool
  default     = true
  
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

## Geo block
variable "block_locations" {
  type    = list(string)
  default = ["RU", "CN", "KP"]
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

variable "incoming_request_patterns_for_proxy" {
  description = "Pattern to match the incoming requests against"
  type        = set(string)
}
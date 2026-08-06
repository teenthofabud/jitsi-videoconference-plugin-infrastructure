variable "api_dns_record_name" {
  description = "The name of the DNS record to create for the api endpoint"
  type        = string
  default     = "api"
}

variable "domain_name" {
  description = "The domain name to be used with Cloudflare."
  type        = string
}

variable "api_endpoint" {
    description = "API endpoint to the video conference moderator (lambda function URL)"
    type = string
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
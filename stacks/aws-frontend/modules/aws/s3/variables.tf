variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to create resources in"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket (must be globally unique)"
}

variable "acl" {
  type        = string
  default     = "private"
  description = "ACL for the bucket (default: private). If enable_public_read is true, acl is set to public-read."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "If true, Terraform will delete all objects (including versioned objects) when destroying the bucket."
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Enable S3 versioning"
}

variable "enable_website" {
  type        = bool
  default     = false
  description = "Enable static website hosting"
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Index document for website hosting"
}

variable "error_document" {
  type        = string
  default     = "error.html"
  description = "Error document for website hosting"
}

variable "enable_public_read" {
  type        = bool
  default     = false
  description = "If true, bucket objects are made publicly readable (policy + public ACLs adjusted). Use with caution."
}

variable "public_read_condition" {
  type        = any
  default     = null
  description = "Optional additional Condition block (map) to put inside the public-read statement. Use null to omit."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to the bucket"
}


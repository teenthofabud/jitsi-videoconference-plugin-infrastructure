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
  description = "Jitsi web static site component configuration."
  type = object({
    index_document       = string
    error_document       = string
    force_destroy        = bool
    enable_versioning    = bool
    enable_website       = bool
    enable_public_read   = bool
    tags                 = map(string)
    prevent_destroy      = bool
    create_before_destroy = bool
    ignore_changes = bool
  })
}
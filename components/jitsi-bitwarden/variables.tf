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
  description = "Jitsi Bitwarden component configuration."
  type = object({
    org_id = string
  })
}

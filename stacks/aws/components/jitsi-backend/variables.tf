variable "context" {
  description = "Common deployment context shared by all Jitsi components."
  type = object({
    project_name = string
    environment  = string
    aws_region   = string
    common_tags  = map(string)
  })
}

variable "terraform_state_bucket" {
  type        = string
  description = "Terraform state bucket for the Aiven stack"
}

variable "config" {
  description = "Jitsi backend component configuration."

  type = object({
    moderator = object({
      function_name         = string
      handler               = string
      runtime               = string
      architectures         = list(string)
      memory_size           = number
      timeout               = number
      log_retention_in_days = number
      tags                  = map(string)

      function_url = optional(object({
        auth_type         = string
        invoke_mode       = string
        allow_credentials = bool
        allow_headers     = list(string)
        allow_methods     = list(string)
        allow_origins     = list(string)
        expose_headers    = list(string)
        max_age           = number
      }))
    })

    db_ping = object({
      function_name         = string
      handler               = string
      runtime               = string
      architectures         = list(string)
      memory_size           = number
      timeout               = number
      log_retention_in_days = number
      tags                  = map(string)

      schedule = optional(object({
        expression                   = string
        timezone                     = string
        state                        = string
        input                        = string
        maximum_event_age_in_seconds = number
        maximum_retry_attempts       = number
      }))
    })

    auth0 = object({
      domain = string
      api_identifier = string
    })
  })
}

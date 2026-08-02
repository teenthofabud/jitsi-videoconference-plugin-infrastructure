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

variable "use_local_mock" {
  description = "Whether to locally mock aws using floci"
  type        = bool
}

variable "terraform_state_bucket" {
  description = "tfstate bucket name of the Aiven stack"
  type        = string
}

variable "deployments" {
  description = "Environment and region specific deployment configuration."

  type = map(object({
    features = object({
      jitsi_web  = bool
      jitsi_vpc  = bool
      jitsi_backend = bool
    })

    jitsi_web = optional(object({
      index_document     = string
      error_document     = string
      force_destroy      = bool
      enable_versioning  = bool
      enable_website     = bool
      enable_public_read = bool
      tags               = map(string)
    }))

    jitsi_vpc = optional(object({
      vpc = object({
        cidr = string
        tags = map(string)
      })

      subnet = object({
        cidr = string
        tags = map(string)
      })

      gateway_endpoint = object({
        service_name    = string
        route_table_ids = list(string)
        tags            = map(string)
      })
    }))

    jitsi_iam = optional(object({
      gh_actions_s3_deploy_role_name = string
      gh_actions_role_policy_name    = string
    }))

    jitsi_backend = optional(object({
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
          expression = string
          timezone   = string
          state      = string
          input      = string
          maximum_event_age_in_seconds = number
          maximum_retry_attempts       = number
        }))
      })
    }))
  }))
}
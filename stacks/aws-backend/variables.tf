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


variable "deployments" {
  description = "Environment and region specific deployment configuration."

  type = map(object({
    features = object({
      jitsi_vpc     = bool
      jitsi_backend = bool
    })


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

        spring_config = optional(object({
          hikari_max_pool_size  = number
          hikari_min_idle_count = number
        }))
      })

      db_ping = object({
        enable_db_ping        = bool
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

      outlook_graph_renewal = object({
        enable_renewal        = bool
        function_name         = string
        handler               = string
        runtime               = string
        architectures         = list(string)
        memory_size           = number
        timeout               = number
        log_retention_in_days = number
        tags                  = map(string)
        schedule = object({
          expression                   = string
          timezone                     = string
          state                        = string
          input                        = string
          maximum_event_age_in_seconds = number
          maximum_retry_attempts       = number
        })
      })
      auth0 = object({
        domain         = string
        api_identifier = string
      })
    }))
  }))
}

variable "moderator_db_config" {
  type = object({
    username = string
    password = string
    db_name  = string
    host     = string
    port     = string
    schema   = string
  })
  sensitive = true
}

variable "aiven_ping_db_config" {
  type = object({
    username = string
    password = string
    url      = string
  })
  sensitive = true
  default   = null
}

variable "outlook_graph_renewal_config" {
  description = "Microsoft Graph application credentials and Outlook renewal settings."
  type = object({
    client_id            = string
    client_secret        = string
    tenant               = string
    redirect_uri         = string
    public_base_url      = string
    token_encryption_key = string
    scopes               = string
  })
  sensitive = true
  default   = null
}

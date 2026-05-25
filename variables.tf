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

  type = map(map(object({
    features = object({
      jitsi_web       = bool
      jitsi_vpc       = bool
    })

    jitsi_web = optional(object({
      index_document         = string
      error_document         = string
      force_destroy          = bool
      enable_versioning      = bool
      enable_website         = bool
      enable_public_read     = bool
      tags                   = map(string)
      prevent_destroy        = bool
      create_before_destroy  = bool
      ignore_changes         = bool
    }))

    jitsi_vpc = optional(object({
      vpc = object({
        cidr = string
        tags  = map(string)
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
  })))
}
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
      jitsi_web     = bool
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

  }))
}


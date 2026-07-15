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
  description = "Jitsi Lambda component configuration."
  type = object({
    migration_lambda = object({
      use_s3_artifact      = optional(bool, false)
      filename             = optional(string)
      s3_bucket            = optional(string)
      s3_key               = optional(string)
      handler              = string
      runtime              = optional(string, "java21")
      memory_size          = optional(number, 512)
      timeout              = optional(number, 60)
      log_retention_in_days = optional(number, 7)
      environment_variables = optional(map(string), {})
      tags                 = optional(map(string), {})
    })

    backend_lambda = object({
      use_s3_artifact      = optional(bool, false)
      filename             = optional(string)
      s3_bucket            = optional(string)
      s3_key               = optional(string)
      handler              = string
      runtime              = optional(string, "java21")
      memory_size          = optional(number, 1024)
      timeout              = optional(number, 30)
      log_retention_in_days = optional(number, 7)
      environment_variables = optional(map(string), {})
      tags                 = optional(map(string), {})
    })
  })
}

variable "lambda_role_arn" {
  description = "IAM role ARN used by both Lambda functions."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for VPC-attached Lambdas."
  type        = list(string)
}

variable "lambda_security_group_id" {
  description = "Security group ID for Lambda functions."
  type        = string
}

variable "common_lambda_environment_variables" {
  description = "Environment variables shared by both Lambda functions."
  type        = map(string)
  default     = {}
}
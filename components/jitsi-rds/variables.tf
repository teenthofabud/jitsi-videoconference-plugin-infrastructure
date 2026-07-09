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
  description = "Jitsi RDS component configuration."
  type = object({
    engine_version        = optional(string, "16.3")
    instance_class        = optional(string, "db.t4g.micro")
    allocated_storage     = optional(number, 20)
    max_allocated_storage = optional(number, 50)
    storage_type          = optional(string, "gp2")

    db_name  = string
    username = string

    multi_az                = optional(bool, false)
    backup_retention_period = optional(number, 1)
    backup_window           = optional(string, "03:00-04:00")

    skip_final_snapshot = optional(bool, true)
    deletion_protection = optional(bool, false)

    subnet_group = object({
      tags = optional(map(string), {})
    })

    tags = optional(map(string), {})
  })
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the RDS DB subnet group."
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "Security group ID attached to the RDS instance."
  type        = string
}

variable "db_password" {
  description = "Master database password."
  type        = string
  sensitive   = true
}
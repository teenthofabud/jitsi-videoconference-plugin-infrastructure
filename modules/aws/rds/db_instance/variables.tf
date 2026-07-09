variable "identifier" {
  description = "Unique RDS instance identifier."
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "allocated_storage" {
  description = "Initial allocated storage in GB."
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum autoscaled storage in GB."
  type        = number
}

variable "storage_type" {
  description = "RDS storage type."
  type        = string
}

variable "db_name" {
  description = "Initial database name."
  type        = string
}

variable "username" {
  description = "Master database username."
  type        = string
}

variable "password" {
  description = "Master database password."
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "RDS DB subnet group name."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security group IDs attached to the RDS instance."
  type        = list(string)
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ deployment."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Automated backup retention in days."
  type        = number
  default     = 1
}

variable "preferred_backup_window" {
  description = "Preferred backup window."
  type        = string
  default     = "03:00-04:00"
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot on destroy."
  type        = bool
}

variable "final_snapshot_identifier" {
  description = "Final snapshot identifier if final snapshot is enabled."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the RDS instance."
  type        = map(string)
  default     = {}
}
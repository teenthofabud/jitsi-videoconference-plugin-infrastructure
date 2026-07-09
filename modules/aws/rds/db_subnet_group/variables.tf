variable "name" {
  description = "Name of the RDS DB subnet group."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs to include in the DB subnet group."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the DB subnet group."
  type        = map(string)
  default     = {}
}
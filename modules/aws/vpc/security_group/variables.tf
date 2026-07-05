variable "name" {
  description = "Name of the security group."
  type        = string
}

variable "description" {
  description = "Description of the security group."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the security group."
  type        = map(string)
  default     = {}
}
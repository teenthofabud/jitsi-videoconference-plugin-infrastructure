variable "vpc_id" {
  description = "ID of the VPC where the subnet will be created."
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet, for example 10.0.1.0/24."
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the subnet, for example eu-central-1a."
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether instances launched in this subnet should get public IPs automatically."
  type        = bool
  default     = false
}

variable "subnet_tags" {
  description = "Tags to apply to the subnet."
  type        = map(string)
  default     = {}
}
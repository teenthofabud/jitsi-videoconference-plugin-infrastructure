variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "cidr value for subnet"
  type        = string
}

variable "subnet_tags" {
  description = "tags for identification"
  type        = map(string)
}
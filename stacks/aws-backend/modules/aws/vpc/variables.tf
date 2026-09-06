variable "vpc_cidr" {
  description = "CIDR value for VPC"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for VPC"
  type        = map(string)
}
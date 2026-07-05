variable "vpc_id" {
  description = "ID of the VPC where the route table will be created."
  type        = string
}

variable "route_table_tags" {
  description = "Tags to apply to the route table."
  type        = map(string)
  default     = {}
}
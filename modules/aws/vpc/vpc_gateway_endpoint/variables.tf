variable "region" {
  description = "AWS Region Name"
  type        = string
}

variable "gateway_endpoint_vpc_id" {
  description = "VPC ID For gateway_endpoint"
  type        = string
}

variable "gateway_endpoint_service_name" {
  description = "The AWS gateway endpoint service name to connect to (e.g. S3)."
  type        = string
}

variable "gateway_endpoint_route_table_ids" {
  description = "List of route table IDs to associate with the gateway endpoint."
  type        = list(string)
}

variable "gateway_endpoint_tags" {
  description = "Map of tags to assign to the gateway endpoint."
  type        = map(string)
}

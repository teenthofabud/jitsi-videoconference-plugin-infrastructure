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
  description = "Jitsi VPC component configuration."
  type = object({
    vpc = object({
      cidr = string
      tags  = map(string)
    })
    subnet = object({
      cidr = string
      tags = map(string)
    })
    gateway_endpoint = object({
      service_name    = string
      route_table_ids = list(string)
      tags            = map(string)
    })
  })
}
variable "context" {
  description = "Common deployment context shared by all Jitsi components."
  type = object({
    project_name = string
    environment  = string
    aws_region   = string
    name_prefix  = string
    common_tags  = map(string)
  })
}

variable "config" {
  description = "Jitsi VPC component configuration."
  type = object({
    vpc = object({
      cidr = string
      tags = optional(map(string), {})
    })
    private_subnet_a = object({
      cidr              = string
      availability_zone = string
      tags              = optional(map(string), {})
    })
    private_subnet_b = object({
      cidr              = string
      availability_zone = string
      tags              = optional(map(string), {})
    })
  })
}
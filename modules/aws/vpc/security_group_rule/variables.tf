variable "type" {
  description = "Type of security group rule. Use ingress or egress."
  type        = string
}

variable "from_port" {
  description = "Starting port for the rule."
  type        = number
}

variable "to_port" {
  description = "Ending port for the rule."
  type        = number
}

variable "protocol" {
  description = "Protocol for the rule, for example tcp, udp, icmp, or -1."
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group where this rule will be added."
  type        = string
}

variable "source_security_group_id" {
  description = "Source security group ID allowed by this rule. Used for SG-to-SG rules."
  type        = string
  default     = null
}

variable "cidr_blocks" {
  description = "CIDR blocks allowed by this rule. Used for IP-based rules."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description of the security group rule."
  type        = string
  default     = null
}
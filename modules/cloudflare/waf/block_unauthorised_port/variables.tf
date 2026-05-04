variable "zone_id" {
  type = string
}

variable "allowed_ports" {
  type    = list(number)
  default = [80, 443]
}

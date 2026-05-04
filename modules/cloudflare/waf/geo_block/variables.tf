
variable "  zone_id  " {
  type = string
}

variable "block_locations" {
  type    = list(string)
  default = ["RU", "CN", "KP"]
}
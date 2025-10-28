resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr #"10.0.0.0/16"
  tags       = var.vpc_tags
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags] # Ignore changes to tags to avoid unnecessary updates
  }
}
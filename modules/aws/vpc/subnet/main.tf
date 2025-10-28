resource "aws_subnet" "example" {
  vpc_id     = var.vpc_id      #aws_vpc.main.id
  cidr_block = var.subnet_cidr #"10.0.1.0/24"
  tags       = var.subnet_tags
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags] # Ignore changes to tags to avoid unnecessary updates
  }
}
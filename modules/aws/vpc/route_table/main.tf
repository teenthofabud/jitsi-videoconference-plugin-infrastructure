resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  tags = var.route_table_tags
}
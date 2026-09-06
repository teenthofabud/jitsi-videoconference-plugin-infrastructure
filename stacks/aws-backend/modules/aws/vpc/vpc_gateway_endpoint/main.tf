resource "aws_vpc_endpoint" "gateway_endpoint" {
  vpc_id            = var.gateway_endpoint_vpc_id
  service_name      = "com.amazonaws.${var.region}.${var.gateway_endpoint_service_name}" #"com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.gateway_endpoint_route_table_ids
  # List route table IDs associated with your private subnets
  # Or, if you have multiple subnets/route tables, use a list variable/attribute
  # to reference all relevant ones.


  tags = var.gateway_endpoint_tags

  lifecycle {
    prevent_destroy = false
    ignore_changes  = [tags] # Ignore changes to tags to avoid unnecessary updates
  }
}
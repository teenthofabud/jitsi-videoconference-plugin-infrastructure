output "vpc_endpoint_type" {
  description = "Type of the endpont"
  value       = aws_vpc_endpoint.gateway_endpoint.vpc_endpoint_type
}

output "vpc_endpoint_name" {
  description = "Name of the Service"
  value       = aws_vpc_endpoint.gateway_endpoint.service_name
}

output "vpc_endpoint_id" {
  description = "ID of the VPC Gateway Endpoint"
  value       = aws_vpc_endpoint.gateway_endpoint.id
}
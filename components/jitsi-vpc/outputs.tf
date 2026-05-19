# ----      Jitsi VPC      ---- #

output "jitsi_vpc_id" {
  description = "ID FOR JITSI VPC"
  value       = module.jitsi_vps.vpc_id
}
output "jitsi_subnet_id" {
  description = "ID FOR JITSI SUBNET"
  value       = module.jitsi_subnet.subnet_id
}

output "jitsi_subnet_route_table_ids" {
  description = "The route table ID associated with the subnet created by the module."
  value       = [data.aws_route_table.subnet_rt.id]
}

output "jitsi_gateway_endpoint_service_name" {
  description = "Name Of The gateway_endpoint_service"
  value       = module.jitsi_gateway_endpoint.vpc_endpoint_name
}

output "jitsi_vpc_gateway_endpoint_type" {
  description = "Type of the Endpoint"
  value       = module.jitsi_gateway_endpoint.vpc_endpoint_type
}

output "jitsi_vpc_gateway_endpoint_id" {
  description = "ID of the Gateway Endpoint"
  value       = module.jitsi_gateway_endpoint.vpc_endpoint_id

}
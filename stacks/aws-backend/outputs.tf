
# ---- Jitsi VPC ----

output "jitsi_vpc_id" {
  description = "ID of the Jitsi VPC."
  value       = try(module.jitsi_vpc[0].jitsi_vpc_id, null)
}

output "jitsi_subnet_id" {
  description = "ID of the Jitsi subnet."
  value       = try(module.jitsi_vpc[0].jitsi_subnet_id, null)
}

output "jitsi_subnet_route_table_ids" {
  description = "Route table IDs associated with the Jitsi subnet."
  value       = try(module.jitsi_vpc[0].jitsi_subnet_route_table_ids, null)
}

output "jitsi_vpc_gateway_endpoint_id" {
  description = "ID of the Jitsi VPC gateway endpoint."
  value       = try(module.jitsi_vpc[0].jitsi_vpc_gateway_endpoint_id, null)
}

#---- Jitsi Backend ------------

output "jitsi_backend_moderator_function_url" {
  description = "Function URL to invoke the jitsi-videoconference-moderator service lambda"
  value       = try(module.jitsi_backend[0].moderator_function_url, null)
}
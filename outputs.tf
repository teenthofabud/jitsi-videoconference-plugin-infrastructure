# ---- Jitsi S3 web ----

output "bucket_id_for_static_web" {
  description = "ID/name of the S3 bucket used for the Jitsi static web site."
  value       = try(module.jitsi_web[0].bucket_id_for_static_web, null)
}

output "bucket_arn_for_static_web" {
  description = "ARN of the S3 bucket used for the Jitsi static web site."
  value       = try(module.jitsi_web[0].bucket_arn_for_static_web, null)
}

output "static_web_endpoint" {
  description = "Static website endpoint for the Jitsi S3 bucket."
  value       = try(module.jitsi_web[0].static_web_endpoint, null)
}

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


# --------- Cloudflare -----

output "cloudflare_zone_id" {
  description = "ID of the Cloudflare zone."
  value       = try(module.cloudflare[0].cloudflare_zone_id, null)
}

output "cloudflare_name_servers" {
  description = "Nameservers assigned to the Cloudflare zone."
  value       = try(module.cloudflare[0].cloudflare_name_servers, [])
}
output "jitsi_vpc_id" {
  description = "ID of the Jitsi VPC."
  value       = module.jitsi_vpc.vpc_id
}

output "private_subnet_a_id" {
  description = "ID of private subnet A."
  value       = module.private_subnet_a.subnet_id
}

output "private_subnet_b_id" {
  description = "ID of private subnet B."
  value       = module.private_subnet_b.subnet_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs for Lambda and RDS subnet group."
  value = [
    module.private_subnet_a.subnet_id,
    module.private_subnet_b.subnet_id
  ]
}

output "private_route_table_id" {
  description = "ID of the private route table."
  value       = module.private_route_table.route_table_id
}

output "lambda_security_group_id" {
  description = "Security group ID for Lambda functions."
  value       = module.lambda_security_group.security_group_id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS PostgreSQL."
  value       = module.rds_security_group.security_group_id
}
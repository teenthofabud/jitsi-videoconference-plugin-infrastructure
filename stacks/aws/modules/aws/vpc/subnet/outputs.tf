output "subnet_id" {
  value       = aws_subnet.example.id
  description = "The IDs of the subnets"
}

output "subnet_cidrs" {
  value       = aws_subnet.example.cidr_block
  description = "The CIDR blocks of the subnets"
}
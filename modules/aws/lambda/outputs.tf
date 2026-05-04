output "lambda_function_name" {
  description = "The name of the created Lambda function."
  value       = aws_lambda_function.example.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the created Lambda function."
  value       = aws_lambda_function.example.arn
}

output "lambda_function_invoke_arn" {
  description = "The ARN used to invoke the Lambda function via API Gateway or other AWS services."
  value       = aws_lambda_function.example.invoke_arn
}

output "lambda_function_last_modified" {
  description = "The date Lambda function was last modified."
  value       = aws_lambda_function.example.last_modified
}

output "lambda_function_version" {
  description = "The latest version of the deployed Lambda function."
  value       = aws_lambda_function.example.version
}

output "lambda_function_vpc_subnets" {
  description = "The subnet IDs attached to the Lambda."
  value       = aws_lambda_function.example.vpc_config[0].subnet_ids
}

output "lambda_function_vpc_security_groups" {
  description = "The security group IDs attached to the Lambda."
  value       = aws_lambda_function.example.vpc_config[0].security_group_ids
}

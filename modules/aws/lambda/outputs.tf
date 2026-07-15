output "lambda_function_name" {
  value = aws_lambda_function.example.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.example.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.example.invoke_arn
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda.name
}
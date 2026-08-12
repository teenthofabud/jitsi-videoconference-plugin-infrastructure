output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = aws_lambda_function.this.arn
}

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role."
  value       = aws_iam_role.lambda_execution.arn
}

output "function_url" {
  description = "Lambda Function URL when enabled."
  value       = try(aws_lambda_function_url.this[0].function_url, null)
}

output "scheduler_schedule_arn" {
  description = "ARN of the EventBridge Scheduler schedule when enabled."
  value       = try(aws_scheduler_schedule.this[0].arn, null)
}
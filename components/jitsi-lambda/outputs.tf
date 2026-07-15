output "migration_lambda_function_name" {
  value = module.migration_lambda.lambda_function_name
}

output "migration_lambda_function_arn" {
  value = module.migration_lambda.lambda_function_arn
}

output "backend_lambda_function_name" {
  value = module.backend_lambda.lambda_function_name
}

output "backend_lambda_function_arn" {
  value = module.backend_lambda.lambda_function_arn
}

output "backend_lambda_invoke_arn" {
  value = module.backend_lambda.lambda_invoke_arn
}
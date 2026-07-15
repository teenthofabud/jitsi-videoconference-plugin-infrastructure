module "migration_lambda" {
  source = "../../modules/aws/lambda"
  use_s3_artifact = var.config.migration_lambda.use_s3_artifact
  filename        = var.config.migration_lambda.filename
  s3_bucket       = var.config.migration_lambda.s3_bucket
  s3_key          = var.config.migration_lambda.s3_key
  lambda_function_name = "${var.context.name_prefix}-migration"
  role_for_lambda      = var.lambda_role_arn
  handler_for_lambda   = var.config.migration_lambda.handler
  runtime_for_lambda   = var.config.migration_lambda.runtime
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [var.lambda_security_group_id]
  memory_size = var.config.migration_lambda.memory_size
  timeout     = var.config.migration_lambda.timeout
  log_retention_in_days = var.config.migration_lambda.log_retention_in_days

  environment_variables_for_lambda = merge(
    var.common_lambda_environment_variables,
    var.config.migration_lambda.environment_variables
  )

  tags_for_lambda = merge(
    var.context.common_tags,
    var.config.migration_lambda.tags,
    {
      Name        = "${var.context.name_prefix}-migration"
      Environment = var.context.environment
    }
  )
}

module "backend_lambda" {
  source = "../../modules/aws/lambda"
  use_s3_artifact = var.config.backend_lambda.use_s3_artifact
  filename        = var.config.backend_lambda.filename
  s3_bucket       = var.config.backend_lambda.s3_bucket
  s3_key          = var.config.backend_lambda.s3_key
  lambda_function_name = "${var.context.name_prefix}-backend"
  role_for_lambda      = var.lambda_role_arn
  handler_for_lambda   = var.config.backend_lambda.handler
  runtime_for_lambda   = var.config.backend_lambda.runtime
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [var.lambda_security_group_id]
  memory_size = var.config.backend_lambda.memory_size
  timeout     = var.config.backend_lambda.timeout
  log_retention_in_days = var.config.backend_lambda.log_retention_in_days
  
  environment_variables_for_lambda = merge(
    var.common_lambda_environment_variables,
    var.config.backend_lambda.environment_variables
  )

  tags_for_lambda = merge(
    var.context.common_tags,
    var.config.backend_lambda.tags,
    {
      Name        = "${var.context.name_prefix}-backend"
      Environment = var.context.environment
    }
  )
}
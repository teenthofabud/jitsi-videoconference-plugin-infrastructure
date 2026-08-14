
module "moderator_lambda" {
  source = "../../modules/aws/lambda"

  lambda_function_name         = "${var.config.moderator.function_name}-${var.context.environment}"
  lambda_execution_role_name   = "${var.config.moderator.function_name}-execution-role-${var.context.environment}"
  lambda_execution_policy_name = "${var.config.moderator.function_name}-execution-policy-${var.context.environment}"
  placeholder_zip_path         = "${path.module}/artifacts/placeholder.zip"
  handler                      = var.config.moderator.handler
  runtime                      = var.config.moderator.runtime
  architectures                = var.config.moderator.architectures
  memory_size                  = var.config.moderator.memory_size
  timeout                      = var.config.moderator.timeout
  environment_variables        = local.aiven_database_environment_variables
  log_retention_in_days        = var.config.moderator.log_retention_in_days

  lambda_execution_policy_path = "${path.module}/policies/moderator-execution-policy.json"

  enable_function_url      = true
  function_url_auth_type   = var.config.moderator.function_url.auth_type
  function_url_invoke_mode = var.config.moderator.function_url.invoke_mode
  cors_allow_credentials   = var.config.moderator.function_url.allow_credentials
  cors_allow_headers       = var.config.moderator.function_url.allow_headers
  cors_allow_methods       = var.config.moderator.function_url.allow_methods
  cors_allow_origins       = var.config.moderator.function_url.allow_origins
  cors_expose_headers      = var.config.moderator.function_url.expose_headers
  cors_max_age             = var.config.moderator.function_url.max_age

  enable_schedule = false

  tags = merge(
    var.context.common_tags,
    var.config.moderator.tags
  )
}

module "db_ping_lambda" {
  source = "../../modules/aws/lambda"

  lambda_function_name         = "${var.config.db_ping.function_name}-${var.context.environment}"
  lambda_execution_role_name   = "${var.config.db_ping.function_name}-execution-role-${var.context.environment}"
  lambda_execution_policy_name = "${var.config.db_ping.function_name}-execution-policy-${var.context.environment}"
  placeholder_zip_path         = "${path.module}/artifacts/placeholder.zip"
  handler                      = var.config.db_ping.handler
  runtime                      = var.config.db_ping.runtime
  architectures                = var.config.db_ping.architectures
  memory_size                  = var.config.db_ping.memory_size
  timeout                      = var.config.db_ping.timeout
  environment_variables        = local.aiven_database_environment_variables
  log_retention_in_days        = var.config.db_ping.log_retention_in_days

  lambda_execution_policy_path = "${path.module}/policies/db-ping-execution-policy.json"

  enable_function_url = false

  enable_schedule              = true
  schedule_name                = "${var.config.db_ping.function_name}-execution-${var.context.environment}"
  scheduler_role_name          = "${var.config.db_ping.function_name}-execution-role-${var.context.environment}"
  scheduler_policy_name        = "${var.config.db_ping.function_name}-execution-policy-${var.context.environment}"
  schedule_description         = "Scheduled at every 12h to ping Aiven db to keep it alive"
  schedule_expression          = var.config.db_ping.schedule.expression
  schedule_timezone            = var.config.db_ping.schedule.timezone
  schedule_state               = var.config.db_ping.schedule.state
  schedule_input               = var.config.db_ping.schedule.input
  maximum_event_age_in_seconds = var.config.db_ping.schedule.maximum_event_age_in_seconds
  maximum_retry_attempts       = var.config.db_ping.schedule.maximum_retry_attempts

  tags = merge(
    var.context.common_tags,
    var.config.db_ping.tags
  )
}

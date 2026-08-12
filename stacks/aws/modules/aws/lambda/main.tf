resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}

resource "aws_lambda_function" "this" {
  function_name    = var.lambda_function_name
  description      = var.description
  filename         = var.placeholder_zip_path
  source_code_hash = filebase64sha256(var.placeholder_zip_path)
  package_type     = "Zip"
  role             = aws_iam_role.lambda_execution.arn
  handler          = var.handler
  runtime          = var.runtime
  architectures    = var.architectures
  memory_size      = var.memory_size
  timeout          = var.timeout

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []

    content {
      variables = var.environment_variables
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
      s3_bucket,
      s3_key,
      s3_object_version
    ]
  }

  depends_on = [
    aws_cloudwatch_log_group.this,
    aws_iam_role_policy.lambda_execution
  ]
}

resource "aws_lambda_function_url" "this" {
  count = var.enable_function_url ? 1 : 0

  function_name      = aws_lambda_function.this.function_name
  authorization_type = var.function_url_auth_type
  invoke_mode        = var.function_url_invoke_mode

  cors {
    allow_credentials = var.cors_allow_credentials
    allow_headers     = var.cors_allow_headers
    allow_methods     = var.cors_allow_methods
    allow_origins     = var.cors_allow_origins
    expose_headers    = var.cors_expose_headers
    max_age           = var.cors_max_age
  }
}

resource "aws_lambda_permission" "function_url_public" {
  count = (
    var.enable_function_url &&
    var.function_url_auth_type == "NONE"
  ) ? 1 : 0

  statement_id           = "AllowPublicFunctionUrl"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.this.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}

resource "aws_scheduler_schedule" "this" {
  count = var.enable_schedule ? 1 : 0

  name = coalesce(
    var.schedule_name,
    "${var.lambda_function_name}-schedule"
  )
  description                  = var.schedule_description
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_timezone
  state                        = var.schedule_state

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = aws_lambda_function.this.arn
    role_arn = aws_iam_role.scheduler[0].arn
    input    = var.schedule_input

    retry_policy {
      maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
      maximum_retry_attempts       = var.maximum_retry_attempts
    }
  }

  depends_on = [
    aws_iam_role_policy.scheduler_invoke_lambda
  ]
}
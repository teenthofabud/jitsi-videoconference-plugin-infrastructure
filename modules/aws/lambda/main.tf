resource "aws_lambda_function" "example" {
  function_name = var.lambda_function_name
  role          = var.role_for_lambda
  handler       = var.handler_for_lambda
  runtime       = var.runtime_for_lambda
  filename         = var.use_s3_artifact ? null : var.filename
  source_code_hash = var.use_s3_artifact ? null : filebase64sha256(var.filename)
  s3_bucket         = var.use_s3_artifact ? var.s3_bucket : null
  s3_key            = var.use_s3_artifact ? var.s3_key : null
  s3_object_version = var.use_s3_artifact ? var.s3_object_version : null
  memory_size = var.memory_size
  timeout     = var.timeout

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = var.environment_variables_for_lambda
  }

  tags = var.tags_for_lambda
}
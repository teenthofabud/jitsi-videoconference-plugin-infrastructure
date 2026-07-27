# Lambda function
resource "aws_lambda_function" "example" {
  filename      = var.filename             #"${path.module}/lambda/my-function.jar" # Path to your built JAR file
  function_name = var.lambda_function_name #"example_lambda_function"
  role          = var.role_for_lambda      #aws_iam_role.for_lambda.arn          # Ensure the correct IAM role resource name
  handler       = var.handler_for_lambda   #"com.example.Handler::handleRequest" # Java handler: fully qualified class and method
  runtime       = var.runtime_for_lambda   #"java11"                             # Use appropriate Java runtime

  source_code_hash = filebase64sha256("${var.filename}") # Hash of JAR for versioning

  vpc_config {
    subnet_ids         = var.subnet_ids         #[aws_subnet.private_subnet.id]
    security_group_ids = var.security_group_ids #[aws_security_group.lambda_sg.id]
  }

  environment {
    variables = var.environment_variables_for_lambda #{
    #   ENVIRONMENT = "production"
    #   LOG_LEVEL   = "info"
    # }
  }
  tags = var.tags_for_lambda
}

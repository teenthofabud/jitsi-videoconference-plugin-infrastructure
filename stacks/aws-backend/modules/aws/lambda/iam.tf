resource "aws_iam_role" "lambda_execution" {
  name               = var.lambda_execution_role_name
  assume_role_policy = file("${path.module}/policies/lambda-assume-role.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "lambda_execution" {
  name = var.lambda_execution_policy_name
  role = aws_iam_role.lambda_execution.id
  policy = templatefile(
    var.lambda_execution_policy_path,
    merge(
      var.lambda_execution_policy_variables,
      {
        log_group_arn = aws_cloudwatch_log_group.this.arn
      }
    )
  )
}

resource "aws_iam_role" "scheduler" {
  count              = var.enable_schedule ? 1 : 0
  name               = var.scheduler_role_name
  assume_role_policy = file("${path.module}/policies/scheduler-assume-role.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "scheduler_invoke_lambda" {
  count = var.enable_schedule ? 1 : 0
  name  = var.scheduler_policy_name
  role  = aws_iam_role.scheduler[0].id
  policy = templatefile(
    "${path.module}/policies/scheduler-invoke-lambda.json",
    {
      lambda_function_arn = aws_lambda_function.this.arn
    }
  )
}
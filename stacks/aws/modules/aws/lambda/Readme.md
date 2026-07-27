terraform apply -target=module.name

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_execution_role"

  assume_role_policy = templatefile("${path.module}/lambda-assume-role.json.tpl", {})
}
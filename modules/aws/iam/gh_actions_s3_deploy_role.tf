# create the iam role
resource "aws_iam_role" "gh_actions_s3_deploy_role" {
  name = var.gh_actions_s3_deploy_role_name

  assume_role_policy = var.gh_actions_assume_policy
  tags = var.gh_actions_s3_deploy_role_tags
}

# create the iam policy with required permissions
resource "aws_iam_policy" "policy" {
  name        = var.gh_actions_role_policy_name
  description = var.gh_actions_role_description
  policy      = var.gh_actions_role_policy
  tags = var.gh_actions_role_tags
  
}

# attach the policy to the created role
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.gh_actions_s3_deploy_role.name
  policy_arn = aws_iam_policy.policy.arn
}
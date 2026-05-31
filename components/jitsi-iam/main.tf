# fetch account id
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

module "jitsi_iam" {
  source = "../../modules/aws/iam"
  github_oidc_link = var.config.github_oidc_link
  github_oidc_tags = var.config.github_oidc_tags
  oidc_client_id_list = var.config.oidc_client_id_list
  gh_actions_role_description = var.config.gh_actions_role_description
  gh_actions_role_policy_name = var.config.gh_actions_role_policy_name
  gh_actions_s3_deploy_role_name = var.config.gh_actions_s3_deploy_role_name

  gh_actions_role_policy = templatefile("${path.module}/../../modules/aws/policies/s3_deploy_gh_actions_role_policy.json.tpl",{})
  gh_actions_assume_policy = templatefile("${path.module}/../../modules/aws/policies/s3_deploy_gh_actions_assume_policy.json.tpl", {
    account_id = local.account_id,
    github_org = var.config.github_org
    github_repo = var.config.github_repo
    github_branch = var.config.github_branch
  })

  gh_actions_role_tags = merge(var.config.gh_actions_role_tags,var.context.common_tags)
  gh_actions_s3_deploy_role_tags = merge(var.config.gh_actions_s3_deploy_role_tags,var.context.common_tags)
  
}
variable "github_oidc_link" {
  type = string
  description = "URL of the GitHub OIDC IdP"
}

variable "oidc_client_id_list" {
  type = list(string)
  description = "audience or the intendent recipient of the tokens from the IdP"
}

variable "github_oidc_tags" {
  type = map(string)
}

variable "gh_actions_s3_deploy_role_tags" {
  type = map(string)
}

variable "gh_actions_role_tags" {
  type = map(string)
}

variable "gh_actions_s3_deploy_role_name" {
  type = string
  description = "Name for the GitHub Actions role to deploy website content to S3"
}

variable "gh_actions_assume_policy" {
  type = string
  description = "Assume policy for GitHub Actions role"
}

variable "gh_actions_role_policy_name" {
  type = string
  description = "GitHub Actions roles's policy name"
}

variable "gh_actions_role_description" {
  type = string
}

variable "gh_actions_role_policy" {
  type = string
  description = "Policy for GitHub Action role with required permissions for deploying to S3"
}
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


variable "context" {
  description = "Common deployment context shared by all Jitsi components."
  type = object({
    project_name = string
    environment  = string
    aws_region   = string
    common_tags  = map(string)
  })
}

variable "config" {
  description = "IAM configuration for GitHub Actions OIDC and S3 deployment role."
  type = object({
    gh_actions_s3_deploy_role_name = string
    gh_actions_s3_deploy_role_tags = optional(map(string), {
      Component = "jitsi-iam"
    })
    gh_actions_role_policy_name = string
    gh_actions_role_description = optional(string, "Role to deploy the website content to S3 using GitHub Actions")
    gh_actions_role_tags = optional(map(string), {
      Component = "jitsi-iam"
    })
  })
}
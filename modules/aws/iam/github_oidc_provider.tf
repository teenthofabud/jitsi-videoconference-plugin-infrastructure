# Creates the Github OIDC Provider in AWS
resource "aws_iam_openid_connect_provider" "github_oidc_provider" {
   url = var.github_oidc_link

  client_id_list = var.oidc_client_id_list

  tags =  var.github_oidc_tags
}
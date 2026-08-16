data "terraform_remote_state" "aiven" {
  backend = "s3"

  config = {
    bucket       = var.terraform_state_bucket
    key          = "tfstate/aiven.tfstate"
    region       = var.context.aws_region
    use_lockfile = true
  }
}

locals {
  raw_uri      = data.terraform_remote_state.aiven.outputs.service_uri
  stripped_uri = replace(replace(local.raw_uri, "postgresql://", ""), "postgres://", "")
  aiven_db_uri = "jdbc:postgresql://${local.stripped_uri}"

  aiven_database_environment_variables = {
    DB_HOST     = data.terraform_remote_state.aiven.outputs.service_host
    DB_PORT     = tostring(data.terraform_remote_state.aiven.outputs.service_port)
    DB_NAME     = data.terraform_remote_state.aiven.outputs.database_name
    DB_USERNAME = data.terraform_remote_state.aiven.outputs.service_username
    DB_PASSWORD = data.terraform_remote_state.aiven.outputs.service_password
    DB_URI      = local.aiven_db_uri
  }
}
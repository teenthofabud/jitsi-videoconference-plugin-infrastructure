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
  # Remove "postgres://" or "postgresql://" if present
  no_proto     = replace(replace(local.raw_uri, "postgresql://", ""), "postgres://", "")
  # If the URI contains user credentials (separated by '@'), strip everything before the '@'
  clean_host   = strcontains(local.no_proto, "@") ? element(split("@", local.no_proto), 1) : local.no_proto
  aiven_db_uri = "jdbc:postgresql://${local.clean_host}"

  aiven_service_ping_environment_variables = {
    DB_USERNAME = data.terraform_remote_state.aiven.outputs.service_username
    DB_PASSWORD = data.terraform_remote_state.aiven.outputs.service_password
    DB_URI      = local.aiven_db_uri
  }

  moderator_service_environment_variables = {
    JITSI_DB_USERNAME = data.terraform_remote_state.aiven.outputs.service_username
    JITSI_DB_PASSWORD = data.terraform_remote_state.aiven.outputs.service_password
    JITSI_DB_URL      = local.aiven_db_uri
    JITSI_DB_DIALECT  = "org.hibernate.dialect.PostgreSQLDialect"
    JITSI_DB_DRIVER_CLASS = "org.postgresql.Driver"
    AUTH0_API_IDENTIFIER = var.config.auth0.api_identifier
    AUTH0_DOMAIN = var.config.auth0.domain
  }
}
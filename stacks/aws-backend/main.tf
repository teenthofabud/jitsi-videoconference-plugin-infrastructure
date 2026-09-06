
module "jitsi_vpc" {
  count  = local.features.jitsi_vpc ? 1 : 0
  source = "./components/jitsi-vpc"

  context = local.context
  config  = local.deployment_config.jitsi_vpc
}

module "jitsi_backend" {
  count  = local.features.jitsi_backend ? 1 : 0
  source = "./components/jitsi-backend"

  context                = local.context
  config = {
    moderator = local.deployment_config.jitsi_backend.moderator
    db_ping   = local.deployment_config.jitsi_backend.db_ping
    auth0 = local.deployment_config.jitsi_backend.auth0
    moderator_db_config = var.moderator_db_config
    aiven_ping_db_config = var.aiven_ping_db_config
  }
}


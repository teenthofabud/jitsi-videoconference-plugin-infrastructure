module "jitsi_web" {
  count  = local.features.jitsi_web ? 1 : 0
  source = "./components/jitsi-web"

  context = local.context
  config  = local.deployment_config.jitsi_web
}

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
  terraform_state_bucket = var.terraform_state_bucket
  config = {
    moderator = local.deployment_config.jitsi_backend.moderator
    db_ping   = local.deployment_config.jitsi_backend.db_ping
  }
}


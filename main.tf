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


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

module "cloudflare" {
  count  = local.features.cloudflare && local.features.jitsi_web ? 1 : 0
  source = "./components/jitsi-cloudflare"

  context = local.context
  config = local.deployment_config.cloudflare
  static_web_endpoint = module.jitsi_web[0].static_web_endpoint
}

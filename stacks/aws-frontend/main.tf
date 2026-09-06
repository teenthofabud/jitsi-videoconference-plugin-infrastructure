module "jitsi_web" {
  count  = local.features.jitsi_web ? 1 : 0
  source = "./components/jitsi-web"

  context = local.context
  config  = local.deployment_config.jitsi_web
}

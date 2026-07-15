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

module "jitsi_iam" {
  count  = local.features.jitsi_iam ? 1 : 0
  source = "./components/jitsi-iam"

  context = local.context
  config  = local.deployment_config.jitsi_iam
}

module "jitsi_rds" {
  count  = local.features.jitsi_rds ? 1 : 0
  source = "./components/jitsi-rds"

  context = local.context
  config  = local.deployment.jitsi_rds
  private_subnet_ids    = module.jitsi_vpc[0].private_subnet_ids
  rds_security_group_id = module.jitsi_vpc[0].rds_security_group_id
  db_password = var.db_password
}

module "cloudflare" {
  count  = local.features.cloudflare && local.features.jitsi_web ? 1 : 0
  source = "./components/jitsi-cloudflare"

  context = local.context
  config = local.deployment_config.cloudflare
  static_web_endpoint = module.jitsi_web[0].static_web_endpoint
}

module "jitsi_lambda" {
  count  = local.features.jitsi_lambda ? 1 : 0
  source = "./components/jitsi-lambda"

  context = local.context
  config  = local.deployment_config.jitsi_lambda
  lambda_role_arn          = module.jitsi_iam[0].lambda_role_arn
  private_subnet_ids       = module.jitsi_vpc[0].private_subnet_ids
  lambda_security_group_id = module.jitsi_vpc[0].lambda_security_group_id

  common_lambda_environment_variables = {
    DB_HOST     = module.jitsi_rds[0].db_address
    DB_PORT     = tostring(module.jitsi_rds[0].db_port)
    DB_NAME     = module.jitsi_rds[0].db_name
    DB_USERNAME = local.deployment_config.jitsi_rds.username
    DB_PASSWORD = var.db_password
  }
}
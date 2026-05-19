locals {
  deployment_config = var.deployments[var.environment][var.aws_region]
  features          = local.deployment_config.features

  context = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region

    common_tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
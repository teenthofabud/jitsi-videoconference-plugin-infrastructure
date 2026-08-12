data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# S3 bucket name for the Jitsi web static site; using regional namespace
locals {
  bucket_name_prefix = lower(replace(
    "${var.context.project_name}-web-${var.context.environment}",
    "_",
    "-"
  ))

  bucket_name = format(
    "%s-%s-%s-an",
    local.bucket_name_prefix,
    data.aws_caller_identity.current.account_id,
    data.aws_region.current.region
  )
}


# Create the S3 bucket using the reusable S3 static website module.
module "jitsi_static_web" {
  source             = "../../modules/aws/s3"
  bucket_name        = local.bucket_name
  force_destroy      = var.config.force_destroy
  enable_versioning  = var.config.enable_versioning
  enable_website     = var.config.enable_website
  enable_public_read = var.config.enable_public_read
  index_document     = var.config.index_document
  error_document     = var.config.error_document
  tags = merge(
    var.context.common_tags,
    var.config.tags
  )
}

# Policy for Static Website Public Access
resource "aws_s3_bucket_policy" "website_policy" {
  count  = var.config.enable_public_read ? 1 : 0
  bucket = module.jitsi_static_web.bucket_id
  policy = templatefile("${path.module}/policies/jitsi_static_web_pub_access.json", {
    bucket_arn = module.jitsi_static_web.bucket_arn
  })
  depends_on = [module.jitsi_static_web]
}

# This file is to create JSON Output only
resource "null_resource" "jitsi_web_outputfile" {
  triggers = {
    s3_bucket_id_for_static_web  = module.jitsi_static_web.bucket_id
    s3_bucket_arn_for_static_web = module.jitsi_static_web.bucket_arn
    s3_static_web_endpoint       = module.jitsi_static_web.website_endpoint
  }

  provisioner "local-exec" {
    command = <<EOT
    echo "===== $(date '+%Y-%m-%d %H:%M:%S') =====" >> output.json
    terraform output -json >> output.json
    EOT
  }
  depends_on = [module.jitsi_static_web]
}
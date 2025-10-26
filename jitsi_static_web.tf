
# ----      Jitsi static_web"   ---- #

# Generate a random suffix for the bucket name to ensure uniqueness
resource "random_uuid" "static_web_suffix" {
}

# Define local variable for bucket name
locals {
  bucket_name = "${var.tags_jitsi_static_web["project"]}-${terraform.workspace}-${random_uuid.static_web_suffix.result}" #${random_string.bucket_suffix.result}" #${local.random_string}" #${random_string.bucket_suffix.result}"
}

# Create the S3 bucket using the S3 module for Static Website Hosting
module "jitsi_static_web" {
  source = "./modules/aws/s3"

  bucket_name        = local.bucket_name
  force_destroy      = lookup(var.force_destroy_jitsi_static_web, terraform.workspace, false)
  enable_versioning  = lookup(var.enable_versioning_jitsi_static_web, terraform.workspace, false)
  enable_website     = lookup(var.enable_website_jitsi_static_web, terraform.workspace, false)
  enable_public_read = lookup(var.enable_public_read_jitsi_static_web, terraform.workspace, false)
  index_document     = lookup(var.index_document_jitsi_static_web, terraform.workspace, "index.html")
  error_document     = lookup(var.error_document_jitsi_static_web, terraform.workspace, "error.html")
  tags = merge(
    var.tags_jitsi_static_web,
    {
      "CreatedBy"   = "terraform"
      "Environment" = terraform.workspace
    }
  )
}

# Policy for Static Website Public Access

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = module.jitsi_static_web.bucket_id
  policy = templatefile("${path.module}/modules/aws/policies/static_web_pub_access.json.tpl", {
    bucket_arn = module.jitsi_static_web.bucket_arn
  })

  depends_on = [module.jitsi_static_web]
}
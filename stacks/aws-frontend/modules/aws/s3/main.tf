resource "aws_s3_bucket" "s3_bucket" {
  bucket           = var.bucket_name
  bucket_namespace = "account-regional"
  force_destroy    = var.force_destroy
  tags             = var.tags

  lifecycle {
    create_before_destroy = false
    prevent_destroy       = false  # prevent accidental deletion
    ignore_changes        = [tags] # ignore tag changes outside Terraform
  }
}


# Website configuration (created only if enabled)
resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  count  = var.enable_website ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}


# Versioning (created only if enabled)
resource "aws_s3_bucket_versioning" "s3_bucket" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Public access block: when enable_public_read = true we allow public (set blocks to false),
# otherwise block public access (recommended for private buckets)
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.enable_public_read ? false : true
  block_public_policy     = var.enable_public_read ? false : true
  ignore_public_acls      = var.enable_public_read ? false : true
  restrict_public_buckets = var.enable_public_read ? false : true
}
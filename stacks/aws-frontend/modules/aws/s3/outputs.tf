output "bucket_name" {
  value       = aws_s3_bucket.s3_bucket.bucket
  description = "S3 bucket name"
}

output "bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "S3 bucket name / id"
}

output "bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "S3 bucket ARN"
}

output "website_endpoint" {
  value       = try(aws_s3_bucket_website_configuration.s3_bucket[0].website_endpoint, null)
  description = "S3 bucket website endpoint"
}

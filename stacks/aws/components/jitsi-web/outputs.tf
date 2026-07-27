#----      Jitsi S3 web      ---- #
output "bucket_id_for_static_web" {
  description = "value of static_web the bucket id"
  value       = module.jitsi_static_web.bucket_id
}

output "bucket_arn_for_static_web" {
  description = "value of the static_web bucket arn"
  value       = module.jitsi_static_web.bucket_arn
}

output "static_web_endpoint" {
  description = "Static website endpoint for the S3 bucket"
  value       = module.jitsi_static_web.website_endpoint

}
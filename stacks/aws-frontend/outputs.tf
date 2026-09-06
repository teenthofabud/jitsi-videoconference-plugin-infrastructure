# ---- Jitsi S3 web ----

output "bucket_id_for_static_web" {
  description = "ID/name of the S3 bucket used for the Jitsi static web site."
  value       = try(module.jitsi_web[0].bucket_id_for_static_web, null)
}

output "bucket_arn_for_static_web" {
  description = "ARN of the S3 bucket used for the Jitsi static web site."
  value       = try(module.jitsi_web[0].bucket_arn_for_static_web, null)
}

output "static_web_endpoint" {
  description = "Static website endpoint for the Jitsi S3 bucket."
  value       = try(module.jitsi_web[0].static_web_endpoint, null)
}

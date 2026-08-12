output "moderator_function_url" {
  description = "Lambda Function URL of the jitsi-videoconference-moderator"
  value       = try(module.moderator_lambda.function_url, null)
}
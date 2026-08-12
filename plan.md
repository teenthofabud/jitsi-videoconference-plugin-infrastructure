Aiven PostgreSQL
  -> managed in separate Aiven Terraform state

AWS
  -> static website S3 resources
  -> backend GraalVM Lambda
  -> migration Java Lambda
  -> heartbeat Java Lambda
  -> Lambda Function URL
  -> EventBridge Scheduler
  -> IAM roles
  -> CloudWatch log groups

Cloudflare
  -> website DNS and Worker
  -> API subdomain
  -> proxy, WAF, rate limiting, and DDoS protection
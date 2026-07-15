variable "use_s3_artifact" {
  description = "Whether to deploy Lambda code from S3 instead of a local deployment package."
  type        = bool
  default     = true
}

variable "filename" {
  description = "Path to the local Lambda deployment package. Used when use_s3_artifact is false."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "S3 bucket containing the Lambda deployment package. Used when use_s3_artifact is true."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 object key for the Lambda deployment package. Used when use_s3_artifact is true."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version for the Lambda deployment package. Optional when use_s3_artifact is true."
  type        = string
  default     = null
}

variable "lambda_function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "role_for_lambda" {
  description = "IAM role ARN for the Lambda function."
  type        = string
}

variable "handler_for_lambda" {
  description = "Lambda handler, for example com.toab.jitsi.Handler::handleRequest."
  type        = string
}

variable "runtime_for_lambda" {
  description = "Lambda runtime, for example java21."
  type        = string
}

variable "enable_vpc_config" {
  description = "Whether to attach Lambda to a VPC."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "Subnet IDs for VPC-attached Lambda."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security group IDs for VPC-attached Lambda."
  type        = list(string)
  default     = []
}

variable "environment_variables_for_lambda" {
  description = "Environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "memory_size" {
  description = "Lambda memory size in MB."
  type        = number
  default     = 512
}

variable "timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 30
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention in days."
  type        = number
  default     = 7
}

variable "tags_for_lambda" {
  description = "Tags for Lambda and its CloudWatch log group."
  type        = map(string)
  default     = {}
}
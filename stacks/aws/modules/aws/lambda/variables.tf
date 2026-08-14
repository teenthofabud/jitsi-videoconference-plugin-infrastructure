#---------- IAM -----------

variable "lambda_execution_role_name" {
  description = "Name of the Lambda execution IAM role."
  type        = string
}

variable "lambda_execution_policy_name" {
  description = "Name of the inline policy attached to the Lambda execution role."
  type        = string
}

variable "scheduler_role_name" {
  description = "Name of the EventBridge Scheduler IAM role."
  type        = string
  default     = null
}

variable "scheduler_policy_name" {
  description = "Name of the inline policy attached to the Scheduler IAM role."
  type        = string
  default     = null
}

#--------- Lambda -----------

variable "lambda_function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "environment" {
  type = string
  description = "Deployment environment."
}

variable "description" {
  description = "Description of the Lambda function."
  type        = string
  default     = null
}

variable "placeholder_zip_path" {
  description = "Path to the placeholder Lambda deployment ZIP file."
  type        = string
}

variable "handler" {
  description = "Lambda function handler."
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime."
  type        = string
}

variable "architectures" {
  description = "Lambda function architectures."
  type        = list(string)
  default     = ["x86_64"]
}

variable "memory_size" {
  description = "Memory available to the Lambda function in MB."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Lambda function timeout in seconds."
  type        = number
  default     = 3
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 30
}

variable "lambda_execution_policy_path" {
  description = "Path to the Lambda execution policy template supplied by the calling component."
  type        = string
}

variable "lambda_execution_policy_variables" {
  description = "Values passed to the Lambda execution policy template."
  type        = map(string)
  default     = {}
}

variable "enable_function_url" {
  description = "Whether to create a Lambda Function URL."
  type        = bool
  default     = false
}

variable "function_url_auth_type" {
  description = "Authorization type for the Lambda Function URL."
  type        = string
  default     = "AWS_IAM"
}

variable "function_url_invoke_mode" {
  description = "Invocation mode for the Lambda Function URL."
  type        = string
  default     = "BUFFERED"
}

variable "cors_allow_credentials" {
  description = "Whether CORS requests can include credentials."
  type        = bool
  default     = false
}

variable "cors_allow_headers" {
  description = "Headers allowed by the Function URL CORS configuration."
  type        = list(string)
  default     = []
}

variable "cors_allow_methods" {
  description = "Methods allowed by the Function URL CORS configuration."
  type        = list(string)
  default     = ["POST"]
}

variable "cors_allow_origins" {
  description = "Origins allowed by the Function URL CORS configuration."
  type        = list(string)
  default     = []
}

variable "cors_expose_headers" {
  description = "Headers exposed by the Function URL CORS configuration."
  type        = list(string)
  default     = []
}

variable "cors_max_age" {
  description = "Maximum time in seconds that browsers can cache CORS results."
  type        = number
  default     = 0
}

variable "enable_schedule" {
  description = "Whether to create an EventBridge Scheduler schedule."
  type        = bool
  default     = false
}

variable "schedule_name" {
  description = "Name of the EventBridge Scheduler schedule."
  type        = string
  default     = null
}

variable "schedule_description" {
  description = "Description of the EventBridge Scheduler schedule."
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "EventBridge Scheduler rate or cron expression."
  type        = string
  default     = null
}

variable "schedule_timezone" {
  description = "Timezone used to evaluate the schedule expression."
  type        = string
  default     = "UTC"
}

variable "schedule_state" {
  description = "State of the EventBridge Scheduler schedule."
  type        = string
  default     = "ENABLED"
}

variable "schedule_input" {
  description = "JSON input passed to the Lambda function by EventBridge Scheduler."
  type        = string
  default     = "{}"
}

variable "maximum_event_age_in_seconds" {
  description = "Maximum age of a Scheduler event before it is discarded."
  type        = number
  default     = 86400
}

variable "maximum_retry_attempts" {
  description = "Maximum Scheduler retry attempts."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags applied to resources created by the module."
  type        = map(string)
  default     = {}
}
variable "filename" {
  description = "Name of the code/binary file used by lambda"
  type        = string
}
variable "lambda_function_name" {
  description = "Name of the lambda function"
  type        = string
}

variable "role_for_lambda" {
  description = "Role for Lambda execution"
  type        = string
}

variable "handler_for_lambda" {
  description = "Handler for Lambda function"
  type        = string
}

variable "runtime_for_lambda" {
  description = "Runtime environment for Lambda function"
  type        = string
}

variable "subnet_ids" {
  description = "value of privet subnet to protect lambda from public"
  type        = list(string)
}

variable "security_group_ids" {
  description = "security group for lambda"
  type        = list(string)
}

variable "environment_variables_for_lambda" {
  description = "Environment variables for Lambda function"
  type        = map(string)
}

variable "tags_for_lambda" {
  description = "Tags to assign to the Lambda function"
  type        = map(string)
}


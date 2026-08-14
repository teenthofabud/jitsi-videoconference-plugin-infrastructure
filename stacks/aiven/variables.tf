variable "aiven_project" {
  description = "Name of the Aiven project."
  type        = string
}

variable "service_name" {
  description = "Name of the Aiven PostgreSQL service."
  type        = string
}

variable "plan" {
  description = "Aiven PostgreSQL service plan."
  type        = string
}

variable "db_cloud_name" {
  description = "Cloud provider and the desired region in the format {provider-region}, Eg:- do-fra --> digital ocean, Frankfurt"
  type = string
}

variable "tech_emails" {
  description = "Email addresses that receive technical alerts and service updates."
  type        = set(string)
  default     = []
}

variable "termination_protection" {
  description = "Whether to protect the PostgreSQL service from deletion."
  type        = bool
  default     = true
}



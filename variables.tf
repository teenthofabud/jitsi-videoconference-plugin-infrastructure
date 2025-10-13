##                    BITWARDEN                    ##

variable "project_name" {
  description = "Project-name"
  type        = map(string)
}

variable "org_id" {
  description = "Bitwarden Organisation ID"
  type        = map(string)
}

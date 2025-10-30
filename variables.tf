##                    BITWARDEN                    ##

variable "project_name" {
  description = "Project-name"
  type        = map(string)
}

variable "org_id" {
  description = "Bitwarden Organisation ID"
  type        = map(string)
}

##                    AWS                    ##

variable "aws_region" {
  type        = map(string)
  description = "AWS region to create resources in"
}

##    static_web    ##

variable "index_document_jitsi_static_web" {
  description = "Index document for website hosting"
  type        = map(string)
}

variable "error_document_jitsi_static_web" {
  description = "Error document for website hosting"
  type        = map(string)
}

variable "force_destroy_jitsi_static_web" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = map(bool)
}

variable "enable_versioning_jitsi_static_web" {
  description = "A boolean that indicates whether versioning is enabled for the bucket."
  type        = map(bool)
}

variable "enable_website_jitsi_static_web" {
  description = "A boolean that indicates whether to enable static website hosting."
  type        = map(bool)
}

variable "enable_public_read_jitsi_static_web" {
  description = "A boolean that indicates whether to enable public read access to the bucket."
  type        = map(bool)
}

variable "tags_jitsi_static_web" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}


##    jitsi_vpc_subnet    ##

variable "jitsi_vpc_cidr" {
  description = "value"
  type        = map(string)
}

variable "jitsi_vpc_tag" {
  description = "value"
  type        = map(string)
}

variable "jitsi_subnet_cidr" {
  description = "value"
  type        = map(string)
}

variable "jitsi_subnet_tags" {
  description = "value"
  type        = map(string)
}

##    jitsi_vpc_gateway_endpoint   ##

variable "jitsi_gateway_endpoint_service_name" {
  description = "The AWS gateway endpoint service name to connect to (e.g. s3)."
  type        = map(string)
}

# variable "jitsi_endpoint_route_table_ids" {
#   description = "List of route table IDs to associate with the gateway endpoint."
#   type        = map(list(string))
# }

variable "jitsi_gateway_endpoint_tags" {
  description = "Map of tags to assign to the gateway endpoint."
  type        = map(string)
}
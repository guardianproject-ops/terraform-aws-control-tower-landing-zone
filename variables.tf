######################
# REQUIRED VARIABLES #
######################

variable "email_address_account_audit" {
  description = "The email address to use for the account to use for audit."
  type        = string
}

variable "email_address_account_log_archiver" {
  description = "The email address to use for the account to use for centralized logging."
  type        = string
}

######################
# OPTIONAL VARIABLES #
######################

variable "access_logging_bucket_retention_days" {
  description = "The number of days to retain log objects in the centralized access logging bucket."
  type        = number
  default     = 3650
}

variable "account_name_audit" {
  description = "The name of the account to use for audit."
  type        = string
  default     = "Audit"
}

variable "account_name_log_archiver" {
  description = "The name of the account to use for centralized logging."
  type        = string
  default     = "Log archive"
}

variable "additional_organizational_unit_name" {
  description = "The name of an additional organizational unit to create in AWS Control Tower."
  type        = string
  default     = "Custom"
}

variable "create_operation_timeout" {
  description = "The amount of time allowed for the create operation to take before being considered to have failed."
  type        = string
  default     = "60m"
}

variable "delete_operation_timeout" {
  description = "The amount of time allowed for the delete operation to take before being considered to have failed."
  type        = string
  default     = "60m"
}

variable "enable_access_management" {
  description = "Whether to enable access management in AWS Control Tower."
  type        = bool
  default     = true
}

variable "foundational_organizational_unit_name" {
  description = "The name of the organizational unit to create in AWS Control Tower which houses the Audit and Log accounts"
  type        = string
  default     = "Core"
}

variable "governed_regions" {
  description = "A list of AWS regions to govern with AWS Control Tower. The region where you deploy the landing zone MUST always be included in this list."
  type        = list(string)
}

variable "kms_key_admins" {
  description = "A list of IAM users or roles that should be granted administrative access to the KMS key."
  type        = list(string)
  default     = []
}

variable "kms_key_alias_name" {
  description = "The alias to use for the KMS key used by AWS Control Tower."
  type        = string
  default     = "control_tower_key"
}

variable "kms_key_users" {
  description = "A list of IAM users or roles that should be granted user access to the KMS key."
  type        = list(string)
  default     = []
}

variable "landing_zone_version" {
  description = "The version of the AWS Control Tower landing zone to deploy."
  type        = string
  default     = "3.3"
}

variable "logging_bucket_retention_days" {
  description = "The number of days to retain log objects in the centralized logging bucket."
  type        = number
  default     = 365
}

variable "update_operation_timeout" {
  description = "The amount of time allowed for the update operation to take before being considered to have failed. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/servicecatalog_provisioned_product#timeouts"
  type        = string
  default     = "60m"
}

variable "existing_key_arn" {
  description = "The ARN of an existing KMS key to use for AWS Control Tower."
  type        = string
  default     = ""
}

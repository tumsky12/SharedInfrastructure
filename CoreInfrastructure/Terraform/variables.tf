variable "resource_group_location" {
  default     = "uksouth"
  description = "Location of the resource group."
}

variable "resource_prefix" {
  default     = "core"
  description = "Prefix of the resource."
}

variable "resource_environment" {
  default     = "dev"
  description = "Environment of the resource."
  validation {
    condition     = contains(["dev", "stg", "prd"], var.resource_environment)
    error_message = "The environment must be either 'dev', 'stg' or 'prd'."
  }
}

variable "resource_group_location" {
  default     = "uksouth"
  description = "Location of the resource group."
}

variable "resource_prefix" {
  default     = "shared"
  description = "Prefix of the resource."
}

variable "unique_suffix_int" {
  default     = 1337
  description = "Resource int suffix to guarantee global uniqueness."
}

variable "unique_suffix_string" {
  default     = "abracadabra"
  description = "Resource string suffix to guarantee global uniqueness."
}

variable "resource_environment" {
  default     = "dev"
  description = "Environment of the resource."
  validation {
    condition     = contains(["dev", "stg", "prd"], var.resource_environment)
    error_message = "The environment must be either 'dev', 'stg' or 'prd'."
  }
}

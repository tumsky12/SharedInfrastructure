variable "resource_group_location" {
  default     = "uksouth"
  description = "Location of the resource group."
}

variable "resource_prefix" {
  default     = "shared"
  description = "Prefix of the resource."
}

variable "resource_suffix" {
  default     = "prod"
  description = "Prefix of the resource."
}

variable "shared_resource_group_name" {
  default =  "${var.resource_prefix}-rg-${var.resource_suffix}"
  description = "Name of the shared infra resource group."  
}
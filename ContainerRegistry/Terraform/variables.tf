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

variable "owner_user_object_id" {
  default     = "2392353a-6d6f-43b4-b415-a0aa98c39299"
  description = "Object ID of owner."
}

variable "container_registry_name" {
  default     = "sharedContainerRegistryProd"
  description = "Name of the container registry."
}

variable "resource_group_location" {
  default     = "uksouth"
  description = "Location of the resource group."
}

variable "resource_prefix" {
  default     = "kubs"
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

variable "container_registry_resource_prefix" {
  default     = "shared"
  description = "Prefix of the container registry resource"
}

variable "default_node_pool_vm_size" {
  default     = "Standard_B2s"
  description = "The default node pool size for the cluster."
}

variable "default_node_pool_name" {
  default     = "system"
  description = "The name of the default node pool."
  validation {
    condition     = contains(["system", "default"], var.default_node_pool_name)
    error_message = "The name of the default node pool must be 'system' or 'default'."
  }
}

variable "kubernetes_sku_tier" {
  default     = "Free"
  description = "The sku tier for the kubernetes cluster."
  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.kubernetes_sku_tier)
    error_message = "The sku tier must be either 'Free', 'Standard' or 'Premium'."
  }
}

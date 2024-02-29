# None sensitive environment configuration only!
# KV to be used for sensitve configuration values.
resource_group_location   = "uksouth"
resource_prefix           = "kubs"
resource_environment      = "stg"
default_node_pool_vm_size = "Standard_B2s"
kubernetes_sku_tier       = "Free"
default_node_pool_name    = "system"

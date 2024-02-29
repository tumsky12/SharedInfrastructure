resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-${var.resource_prefix}-${var.resource_environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.resource_prefix}-k8s"
  node_resource_group = "rg-${var.resource_prefix}-infra-${var.resource_environment}"
  sku_tier            = var.kubernetes_sku_tier

  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = 1
    vm_size         = var.default_node_pool_vm_size
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.resource_environment
  }
}

resource "azurerm_role_assignment" "ra" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.cr.id
  skip_service_principal_aad_check = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw

  sensitive = true
}

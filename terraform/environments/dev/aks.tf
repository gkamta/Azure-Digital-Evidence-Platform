# ============================================================
# Phase 2 - Azure Kubernetes Service
# Digital Evidence Platform
# ============================================================

resource "azurerm_kubernetes_cluster" "platform" {
  name                = "aks-evidence-dev"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  dns_prefix          = "aks-evidence-dev"

  # Enable OIDC / Workload Identity for Azure authentication
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_D2s_v4"
    vnet_subnet_id = azurerm_subnet.aks.id

    os_disk_size_gb = 64

    tags = local.common_tags
  }

  # Azure-managed identity instead of service principal credentials
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"

    service_cidr   = "10.21.0.0/16"
    dns_service_ip = "10.21.0.10"
  }

  role_based_access_control_enabled = true

  tags = local.common_tags
}

# ============================================================
# Allow AKS to pull images from ACR
# ============================================================

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.platform.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.platform.kubelet_identity[0].object_id
}
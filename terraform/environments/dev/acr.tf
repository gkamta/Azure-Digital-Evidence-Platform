# ============================================================
# Phase 2 - Azure Container Registry
# Digital Evidence Platform
# ============================================================

resource "azurerm_container_registry" "platform" {
  name                = "acrevidenceplatform001"
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location

  sku           = "Basic"
  admin_enabled = false

  tags = local.common_tags
}
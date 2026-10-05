# ============================================================
# Phase 2 - Azure Networking
# Digital Evidence Platform
# ============================================================

# Virtual Network
resource "azurerm_virtual_network" "platform" {
  name                = "vnet-evidence-dev"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = ["10.20.0.0/16"]

  tags = local.common_tags
}

# ============================================================
# AKS Subnet
# ============================================================

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks-dev"
  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.20.1.0/24"]
}

# ============================================================
# Private Endpoint Subnet
# ============================================================

resource "azurerm_subnet" "private_endpoints" {
  name                 = "snet-private-endpoints-dev"
  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.20.2.0/24"]
}

# ============================================================
# Application Subnet
# Reserved for future application/platform components
# ============================================================

resource "azurerm_subnet" "application" {
  name                 = "snet-app-dev"
  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.20.3.0/24"]
}

# ============================================================
# Network Security Group - AKS
# ============================================================

resource "azurerm_network_security_group" "aks" {
  name                = "nsg-aks-dev"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name

  tags = local.common_tags
}

# Associate AKS NSG with AKS subnet
resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}
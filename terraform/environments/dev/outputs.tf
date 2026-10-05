output "resource_group_name" {
  value = azurerm_resource_group.platform.name
}

output "storage_account_name" {
  value = azurerm_storage_account.evidence.name
}

output "evidence_container_name" {
  value = azurerm_storage_container.evidence.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.platform.id
}

output "key_vault_name" {
  value = azurerm_key_vault.platform.name
}

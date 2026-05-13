# ============================================================
# Terraform Outputs
# ============================================================

output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.data_platform_rg.name
}

output "adls_storage_account_name" {
  description = "Name of the ADLS Gen2 storage account."
  value       = azurerm_storage_account.adls.name
}

output "lakehouse_container_name" {
  description = "Name of the lakehouse storage container."
  value       = azurerm_storage_container.lakehouse.name
}

output "databricks_workspace_name" {
  description = "Name of the Azure Databricks workspace."
  value       = azurerm_databricks_workspace.databricks.name
}

output "databricks_workspace_url" {
  description = "URL of the Azure Databricks workspace."
  value       = azurerm_databricks_workspace.databricks.workspace_url
}

output "synapse_workspace_name" {
  description = "Name of the Azure Synapse workspace."
  value       = azurerm_synapse_workspace.synapse.name
}

output "key_vault_name" {
  description = "Name of the Azure Key Vault."
  value       = azurerm_key_vault.key_vault.name
}
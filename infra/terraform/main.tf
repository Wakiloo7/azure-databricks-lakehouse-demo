# ============================================================
# Terraform Infrastructure Template
# Project: Azure Databricks Medallion Lakehouse Portfolio
# Purpose:
#   Skeleton IaC template for Azure data platform resources.
#
# Note:
#   This is a portfolio template only. It is not deployed
#   production infrastructure.
# ============================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

# ============================================================
# Resource Group
# ============================================================

resource "azurerm_resource_group" "data_platform_rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location

  tags = var.common_tags
}

# ============================================================
# Azure Data Lake Storage Gen2
# ============================================================

resource "azurerm_storage_account" "adls" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.data_platform_rg.name
  location                 = azurerm_resource_group.data_platform_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  is_hns_enabled = true

  tags = var.common_tags
}

resource "azurerm_storage_container" "lakehouse" {
  name                  = var.lakehouse_container_name
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

# ============================================================
# Azure Databricks Workspace
# ============================================================

resource "azurerm_databricks_workspace" "databricks" {
  name                = "${var.project_name}-${var.environment}-dbw"
  resource_group_name = azurerm_resource_group.data_platform_rg.name
  location            = azurerm_resource_group.data_platform_rg.location
  sku                 = var.databricks_sku

  tags = var.common_tags
}

# ============================================================
# Azure Synapse Workspace
# ============================================================

resource "azurerm_synapse_workspace" "synapse" {
  name                                 = "${var.project_name}-${var.environment}-synapse"
  resource_group_name                  = azurerm_resource_group.data_platform_rg.name
  location                             = azurerm_resource_group.data_platform_rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_container.lakehouse.resource_manager_id

  sql_administrator_login          = var.synapse_sql_admin_user
  sql_administrator_login_password = var.synapse_sql_admin_password

  tags = var.common_tags
}

# ============================================================
# Azure Key Vault
# ============================================================

resource "azurerm_key_vault" "key_vault" {
  name                       = "${var.project_name}-${var.environment}-kv"
  location                   = azurerm_resource_group.data_platform_rg.location
  resource_group_name        = azurerm_resource_group.data_platform_rg.name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  tags = var.common_tags
}
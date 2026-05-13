# ============================================================
# Terraform Variables
# ============================================================

variable "project_name" {
  description = "Project name used for Azure resource naming."
  type        = string
  default     = "medallion-lakehouse"
}

variable "environment" {
  description = "Deployment environment name, for example dev, test, or prod."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources."
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "Globally unique ADLS Gen2 storage account name."
  type        = string
}

variable "lakehouse_container_name" {
  description = "ADLS container name for the lakehouse."
  type        = string
  default     = "lakehouse"
}

variable "databricks_sku" {
  description = "Azure Databricks workspace SKU."
  type        = string
  default     = "standard"
}

variable "synapse_sql_admin_user" {
  description = "Synapse SQL administrator username."
  type        = string
  sensitive   = true
}

variable "synapse_sql_admin_password" {
  description = "Synapse SQL administrator password."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID for Key Vault."
  type        = string
}

variable "common_tags" {
  description = "Common tags for Azure resources."
  type        = map(string)
  default = {
    project     = "azure-databricks-medallion-lakehouse"
    owner       = "portfolio"
    environment = "dev"
  }
}
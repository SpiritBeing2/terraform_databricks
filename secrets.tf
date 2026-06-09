data "azurerm_key_vault" "this" {
	name = var.vault_name
	resource_group_name = var.resource_group_vault
}

data "azurerm_key_vault_secret" "dbk_metastore_id" {
	name = "databricksMetastoreId"
	key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dbk_client_id" {
        name = "clientId"
        key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dbk_client_secret" {
        name = "clientSecret"
        key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "dbk_account_id" {
        name = "accountId"
        key_vault_id = data.azurerm_key_vault.this.id
}

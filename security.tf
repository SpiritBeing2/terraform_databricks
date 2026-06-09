resource "azurerm_user_assigned_identity" "this" {
	name = "mi-adb-dev"
	resource_group_name = azurerm_resource_group.this.name
	location = azurerm_resource_group.this.location

}

resource "azurerm_databricks_access_connector" "this" {
        name = "ac-dbx-uc-dev"
        resource_group_name = azurerm_resource_group.this.name
        location = azurerm_resource_group.this.location

        identity {
                type = "UserAssigned"
		identity_ids = [azurerm_user_assigned_identity.this.id]
	}

}

# RBAC to lake

resource "azurerm_role_assignment" "this" {
	scope                = azurerm_storage_account.this.id
	role_definition_name = "Storage Blob Data Owner"
	principal_id = azurerm_user_assigned_identity.this.principal_id	
}




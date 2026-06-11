resource "databricks_storage_credential" "this" {
  provider = databricks.workspace
  name     = "sc-adls-${local.env}-2"

  azure_managed_identity {
    managed_identity_id = azurerm_user_assigned_identity.this.id
    access_connector_id = azurerm_databricks_access_connector.this.id
  }
  depends_on = [
    databricks_metastore_assignment.this,
    azurerm_role_assignment.this
  ]
  comment = "Unity Catalog access to ADLS via Access Connector"

}


resource "databricks_external_location" "this" {
  name            = "extloc-bronze-${local.env}"
  provider        = databricks.workspace
  url             = "abfss://bronze-${local.env}@${azurerm_storage_account.this.name}.dfs.core.windows.net/"
  credential_name = databricks_storage_credential.this.name
  depends_on = [
    azurerm_storage_data_lake_gen2_filesystem.this
  ]
  comment = "External location for bronze container"
}


# Metastore et ressources

resource "databricks_metastore_assignment" "this" {
  provider = databricks.accounts

  metastore_id = data.azurerm_key_vault_secret.dbk_metastore_id.value
  workspace_id = azurerm_databricks_workspace.this.workspace_id

}

resource "databricks_catalog" "this" {
  provider     = databricks.workspace
  name         = local.env
  comment      = "Development catalog"
  storage_root = "abfss://bronze-${local.env}@${azurerm_storage_account.this.name}.dfs.core.windows.net/catalog/dev"
  depends_on = [
    databricks_metastore_assignment.this,
    databricks_external_location.this
  ]
}

resource "databricks_schema" "bronze" {
  provider     = databricks.workspace
  catalog_name = databricks_catalog.this.name
  name         = "bronze-${local.env}"
}

resource "databricks_schema" "silver" {
  provider     = databricks.workspace
  catalog_name = databricks_catalog.this.name
  name         = "silver-${local.env}"
}

resource "databricks_schema" "gold" {
  provider     = databricks.workspace
  catalog_name = databricks_catalog.this.name
  name         = "gold-${local.env}"
}


resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                = "stdatabricks${local.env}003"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  is_hns_enabled = true
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  name               = "bronze-${local.env}"
  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_databricks_workspace" "this" {
  name                = "dbw-${local.env}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku                         = "premium"
  managed_resource_group_name = "rg-adb-${local.env}-managed"


  custom_parameters {
    virtual_network_id  = azurerm_virtual_network.this.id
    public_subnet_name  = azurerm_subnet.public.name
    private_subnet_name = azurerm_subnet.private.name

    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id

    no_public_ip = true
  }
}


module "platform" {
  source = "../../modules/"

  location            = var.location
  environment         = var.environment
  resource_group_name = var.resource_group_name

  resource_group_vault = var.resource_group_vault
  vault_name = var.vault_name
  cluster = var.cluster

  providers = {
    databricks.account = databricks.account
    databricks.workspace = databricks.workspace
  }
	
}


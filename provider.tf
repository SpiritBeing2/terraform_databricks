terraform {
	required_version = ">= 1.5.0"

	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "~> 4.0"
		}
		databricks = {
			source = "databricks/databricks"
			version = "~> 1.80"
		}
	}
	backend "azurerm" {
	   resource_group_name = "terraform"
	   storage_account_name = "statesterraform1996"
	   container_name = "terraform"
	   key = "dev.terraform.state"

	}
}

provider "azurerm" {
	features {}
}

provider "databricks" {
	alias = "accounts"
	host = "https://accounts.azuredatabricks.net"
	account_id = "${data.azurerm_key_vault_secret.dbk_account_id.value}"
	auth_type = "oauth-m2m"
	client_id = "${data.azurerm_key_vault_secret.dbk_client_id.value}" 
	client_secret = "${data.azurerm_key_vault_secret.dbk_client_secret.value}"
}

provider "databricks" {
  	alias = "workspace"
  	host  = "https://${azurerm_databricks_workspace.this.workspace_url}"
	azure_workspace_resource_id = azurerm_databricks_workspace.this.id
}



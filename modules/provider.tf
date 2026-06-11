terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.80"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "statesterraform1996"
    container_name       = "terraform"
    key                  = "dev.terraform.state"

  }
}

provider "azurerm" {
  features {}
}


terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-southeastasia"
    storage_account_name = "cs1100320012ca50c40"
    container_name       = "tfstate"
    key                  = "codelab.microsoft.tfstate"
  }
}

provider "azurerm" {
  features {}
}

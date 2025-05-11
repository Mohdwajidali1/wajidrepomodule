terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
#   backend "azurerm" {
#     resource_group_name = "rgmukesh"
#     storage_account_name = "mukeshchikane"
#     container_name = "mukeshwajid"
#     key = "terraform.tfstate"
    
#   }
}

provider "azurerm" {
  features {}


  subscription_id = "c2a5c5cb-b9fd-4664-8a84-eeedff993633"
}

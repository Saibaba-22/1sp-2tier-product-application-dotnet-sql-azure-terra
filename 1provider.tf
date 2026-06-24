# version setting block 

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.56.0"
    }
  }
}

# provider block 
provider "azurerm" {
  features {}
    # configuration options
  client_id = ""
  client_secret = ""
  tenant_id = ""
  subcription_id  = ""
}


/*
# backend block 
terraform {
  backend "azurerm" {
    access_key = "Access_key"
    storage_account_name = "storage_account_name"
    container_name = "container_name"
    key = "prod.terraform.tfstate"
  }
}
*/
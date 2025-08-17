# We strongly recommend using the required_providers block to set the Fabric Provider source and version being used
terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.4.0" # Check for the latest version on the Terraform Registry
    }
  }

  backend "azurerm" {
    resource_group_name  = "msfabric-rg"
    storage_account_name = "msfabricst"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Fabric Provider
provider "fabric" {
  use_cli   = true
  tenant_id = "8c50900e-2b23-462e-ac02-2ee3ace1c43b"
}

resource "fabric_workspace" "ws1" {
  display_name = "tfbronze"
  description  = "TF Bronze orkspace"
}



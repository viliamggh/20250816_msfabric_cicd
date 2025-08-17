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

# Grant your user account Admin access to the workspace
resource "fabric_workspace_role_assignment" "user_admin" {
  workspace_id = fabric_workspace.ws1.id
  principal = {
    id   = "9edfaa63-91e6-4648-b87a-004e6f982e19" 
    type = "Group"
  }
  role = "Admin"
}

# Grant the UAMI Admin access to the workspace (for future operations)
# resource "fabric_workspace_role_assignment" "uami_admin" {
#   workspace_id = fabric_workspace.ws1.id
#   principal = {
#     id   = "eae1daaa-a909-4e2b-9907-f5a56229538b"  # Your UAMI client ID
#     type = "ServicePrincipal"
#   }
#   role = "Admin"
# }

resource "fabric_data_pipeline" "dummy_pipeline" {
  display_name          = "dummy_pipeline"
  description   = "A dummy data pipeline for testing purposes"
  workspace_id  = fabric_workspace.ws1.id

  # Add any required dummy configurations here
  # Removed unsupported properties block
}



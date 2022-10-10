#---CHANGE-LOG----------------------------------------------------------------
# Author: David Rahäuser (Fractiunate)
# Updated: <Date>
# Features: a,b,c
#---CHANGE-LOG----------------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }

  }
  backend "local" {
  }

}
provider "azurerm" {
  features {}
}

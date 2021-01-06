terraform {
  required_version = ">= 0.12.6"
  required_providers {
    azuread = ">= 0.5"
    azurerm = ">= 1.32"
    random  = ">= 2.1"
  }
}


terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformstatefile2020" #use existing SA
    container_name       = "tfstate"
    key                  = "azkv.tfstate"
  }
  #required_version = "0.13.3"
}

#Set the Provider
provider "azurerm" {
  #version                    = "2.28.0"
  skip_provider_registration = true #(Optional) Should the AzureRM Provider skip registering the Resource Providers it supports? This can also be sourced from the ARM_SKIP_PROVIDER_REGISTRATION Environment Variable. Defaults to false.
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

}

provider "azuread" {
  #subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}


#############################################################################
# VARIABLES
#############################################################################

variable "subscription_id" {
  description = "Azure subscription Id."
}

variable "tenant_id" {
  description = "Azure tenant Id."
}

variable "client_id" {
  description = "Azure service principal application Id"
}

variable "client_secret" {
  description = "Azure service principal application Secret"
}


variable "location" {
  default = "eastus2"
}

resource "random_id" "test" {
  byte_length = 4
}

resource "azurerm_resource_group" "test" {
  name     = format("test-%s", random_id.test.hex)
  location = var.location
}

module "key_vault" {
  source = "../"

  name = format("test-%s", random_id.test.hex)

  resource_group_name = azurerm_resource_group.test.name

  access_policies = [
    {
      group_names        = ["terraform-acceptance-testing"]
      secret_permissions = ["get"]
    }
  ]

  secrets = {
    "message" = "Hello, world!"
  }

}

data "azurerm_key_vault" "test" {
  name = module.key_vault.name

  resource_group_name = azurerm_resource_group.test.name
}


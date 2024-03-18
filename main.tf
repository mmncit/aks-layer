provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location
}

module "service_principal" {
  source                 = "./modules/service_principal"
  service_principal_name = var.service_principal_name
  depends_on             = [azurerm_resource_group.rg1]
}

resource "azurerm_role_assignment" "role_assignment1" {
  scope                = azurerm_resource_group.rg1.id
  role_definition_name = "Contributor"
  principal_id         = module.service_principal.service_principal_object_id
  depends_on           = [module.service_principal]
}

module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  resource_group_name = var.rgname
  location            = var.location
  depends_on          = [azurerm_role_assignment.role_assignment1]
}

resource "azurerm_key_vault_secret" "kv_secret" {
  name         = module.service_principal.client_id
  value        = module.service_principal.client_secret
  key_vault_id = module.key_vault.key_vault_id
}

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
  depends_on   = [module.key_vault]
}

module "aks" {
  source              = "./modules/aks"
  aks_cluster_name    = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.rgname
  client_id           = module.service_principal.client_id
  client_secret       = module.service_principal.client_secret
  ssh_key             = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  depends_on          = [azurerm_key_vault_secret.kv_secret]
}

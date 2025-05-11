data "azurerm_subnet" "datasubnet" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "datakeyvault" {
  for_each            = var.vms
  name                = each.value.keyvault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "keysecrentusername" {
  for_each = var.vms
  name     = each.value.username_secret
  key_vault_id = data.azurerm_key_vault.datakeyvault[each.key].id
}

data "azurerm_key_vault_secret" "keysecrentpassword" {
  for_each = var.vms
  name     = each.value.password_secret
  key_vault_id = data.azurerm_key_vault.datakeyvault[each.key].id
}
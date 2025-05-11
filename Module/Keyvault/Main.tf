data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault_block" {
  for_each                   = var.vmkeyvault
  name                       = each.value.keyvault_name
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "List",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "keys_block" {
  for_each     = var.vmkeyvault
  name         = each.value.username_secret
  value        = each.value.user_value
  key_vault_id = azurerm_key_vault.keyvault_block[each.key].id
}

resource "azurerm_key_vault_secret" "keys_block1" {
  for_each     = var.vmkeyvault
  name         = each.value.password_secret
  value        = each.value.password_value
  key_vault_id = azurerm_key_vault.keyvault_block[each.key].id
}


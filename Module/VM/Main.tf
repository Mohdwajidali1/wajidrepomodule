resource "azurerm_public_ip" "pip_block" {
  for_each            = var.vms
  name                = each.value.pipname
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"


}

resource "azurerm_network_interface" "nic_block" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_block[each.key].id

  }
}

resource "azurerm_linux_virtual_machine" "vm_block" {
  for_each                        = var.vms
  name                            = each.value.vmname
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = "Standard_F2"
  admin_username                  = data.azurerm_key_vault_secret.keysecrentusername[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.keysecrentpassword[each.key].value
  disable_password_authentication = "false"
  network_interface_ids           = [azurerm_network_interface.nic_block[each.key].id]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

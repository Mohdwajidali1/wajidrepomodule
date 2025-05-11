module "azurerm_resource_group" {
  source = "../../Module/Resourcegroup"
  rgs    = var.rgs

}

module "azurerm_storage_account" {
  source     = "../../Module/Storageacc"
  storages   = var.storages
  depends_on = [module.azurerm_resource_group]

}

module "azurerm_virtual_network" {
  source     = "../../Module/Vnet"
  vnets      = var.vnets
  depends_on = [module.azurerm_resource_group]
}

module "azurerm_subnet" {
  source     = "../../Module/Subnet"
  subnets    = var.subnets
  depends_on = [module.azurerm_virtual_network]

}

module "azurerm_linux_virtual_machine" {
  source     = "../../Module/VM"
  vms        = var.vms
  vmkeyvault  = var.vmkeyvault
  depends_on = [module.azurerm_subnet, module.azurerm_key_vault]

}

module "azurerm_key_vault" {
  source     = "../../Module/Keyvault"
  vmkeyvault = var.vmkeyvault
  depends_on = [ module.azurerm_resource_group ]


}


    

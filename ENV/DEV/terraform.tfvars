rgs = {
  devrg = {
    name     = "rg01"
    location = "westus"
  }
  devrg1 = {
    name     = "rg02"
    location = "westus"
  }
}

storages = {
  stg01 = {
    name                     = "strgwajid"
    location                 = "westus"
    resource_group_name      = "rg01"
    account_tier             = "Standard"
    account_replication_type = "LRS"

  }
}

vnets = {
  vnet01 = {
    name                = "vnetwajid"
    location            = "westus"
    resource_group_name = "rg01"
    address_space       = ["10.0.0.0/16"]
  }

}

subnets = {
  subnet01 = {
    subnet_name          = "subnetwajid"
    resource_group_name  = "rg01"
    virtual_network_name = "vnetwajid"
    address_prefixes     = ["10.0.0.0/24"]
  }
}

vms = {
  vm01 = {
    subnet_name          = "subnetwajid"
    resource_group_name  = "rg01"
    virtual_network_name = "vnetwajid"
    nic_name             = "nicvm"
    location             = "westus"
    vmname               = "mukeshvm"
    pipname              = "vmpip"
    keyvault_name        = "mukeshkey1"
    username_secret      = "username"
    password_secret      = "password"

  }
}

vmkeyvault = {
  vmkeyvault01 = {
    keyvault_name       = "mukeshkey1"
    resource_group_name = "rg01"
    location            = "westus"
    username_secret     = "username"
    user_value          = "Adminuser"
    password_secret     = "password"
    password_value      = "Admin@12341234"
  }

  # vmkeyvault02 = {
  #   keyvault_name       = "mukeshkey1"
  #   resource_group_name = "rg01"
  #   location            = "westus"
  #   keysecretname       = "password"
  #   value               = "Admin@12341234"
  # }
}



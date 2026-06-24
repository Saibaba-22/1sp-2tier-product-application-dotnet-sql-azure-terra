# resource group
resource "azurerm_resource_group" "rg" {
    name = var.rg_rgname
    location = var.rg_rgloc
}

# resource virtual network 
resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_vnetname1
    location = var.vnet_vnetloc1 
    address_space = var.vnet_vnetip
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [ azurerm_resource_group.rg ]
}

# subnet 
resource "azurerm_subnet" "sub1"{
    name = var.sub1_subname 
    address_prefixes = var.sub1_subip
    resource_group_name = azurerm_resource_group.rg.name 
    virtual_network_name = azurerm_virtual_network.vnet.name 
    depends_on = [ azurerm_virtual_network.vnet ]
}



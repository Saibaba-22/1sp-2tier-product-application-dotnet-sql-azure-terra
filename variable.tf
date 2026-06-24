variable rg_rgname {}
variable rg_rgloc {} 
variable vnet_vnetname1 {}
variable vnet_vnetloc1 {} 
variable vnet_vnetip{} 
variable sub1_subname {} 
variable sub1_subip {} 
variable pip1_name{} 
variable nic1_name {} 
variable nsg1_name{} 
variable vm1_name{} 
variable username {} 
variable "password" {
  description = "VM Admin Password"
  type        = string
  sensitive   = true
}


variable mysqlname{}
variable db_name{}
variable db_user{}
variable "db_password" {
  description = "Database Password"
  type        = string
}




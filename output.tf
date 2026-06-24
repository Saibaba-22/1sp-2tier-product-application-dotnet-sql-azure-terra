# SQL ENDPOINT
output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_fqdn" {
  value = azurerm_mysql_flexible_server.mysql.fqdn
}

output "database_name" {
  value = azurerm_mysql_flexible_database.appdb.name
}

# DB Name
output "administrator_login" {
  value = azurerm_mysql_flexible_server.mysql.administrator_login
}

# Dotnet App link 
output "vm_public_ip" {
  value = "http://${azurerm_linux_virtual_machine.vm1.public_ip_addresses[0]}:5001"
}

# Prometheus 
output "prometheus_url" {
  value = "http://${azurerm_linux_virtual_machine.vm1.public_ip_addresses[0]}:9090"
}

output "node_exporter_url" {
  value = "http://${azurerm_linux_virtual_machine.vm1.public_ip_addresses[0]}:9100/metrics"
}

# Grafana 
output "grafana_url" {
  value = "http://${azurerm_linux_virtual_machine.vm1.public_ip_addresses[0]}:3000"
}


resource "azurerm_linux_virtual_machine" "vm1" {
#vm basic 
  name                = var.vm1_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.nic1.id]
  depends_on = [ azurerm_mysql_flexible_server.mysql ]

# VM size 
  os_disk {
    name = "myOSdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

# OS 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

# authentication 
  computer_name  = "studentserver"
  admin_username = var.username
  disable_password_authentication = false 
  admin_password = var.password 

  connection {
      type        = "ssh"
      user        = var.username
      password    = var.password
      host        = self.public_ip_address
    }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "sudo mkdir -p /home/SaiAzadmin/Product-Net",
      "sudo mkdir -p /home/SaiAzadmin/Product-Net/wwwroot",
      "sudo mkdir -p /home/SaiAzadmin/Product-Net/Controllers",
      "sudo mkdir -p /home/SaiAzadmin/Product-Net/Data",
      "sudo mkdir -p /home/SaiAzadmin/Product-Net/Models",      
      "sudo chown -R SaiAzadmin:SaiAzadmin /home/SaiAzadmin/Product-Net"
    ]
  }

provisioner "file" {
  content = templatefile("${path.module}/index.html.tpl", {
    vm_ip = self.public_ip_address
    name   = "Product Inventory"
  })
  destination = "/home/SaiAzadmin/Product-Net/wwwroot/index.html"
}

  provisioner "file" {
    source      = "./DotNet/Product.cs"
    destination = "/home/SaiAzadmin/Product-Net/Models/Product.cs"
  }

  provisioner "file" {
    source      = "./DotNet/AppDbContext.cs"
    destination = "/home/SaiAzadmin/Product-Net/Data/AppDbContext.cs"
  }

  provisioner "file" {
    source      = "./DotNet/ProductsController.cs"
    destination = "/home/SaiAzadmin/Product-Net/Controllers/ProductsController.cs"
  }

    provisioner "file" {
    source      = "./DotNet/Program.cs"
    destination = "/home/SaiAzadmin/Product-Net/Program.cs"
  }


    provisioner "file" {
    source      = "./DotNet/appsettings.json"
    destination = "/home/SaiAzadmin/Product-Net/appsettings.json"
  }

      provisioner "file" {
    source      = "./DotNet/Product-Net.csproj"
    destination = "/home/SaiAzadmin/Product-Net/Product-Net.csproj"
  }

# Inside execute 
  provisioner "remote-exec" {
    inline = [
  "set -e",

  # ---------------- INSTALL DOTNET ----------------
  "sudo apt update -y",
  "sudo apt install -y wget apt-transport-https software-properties-common mysql-client-core-8.0",

  "wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb",
  "sudo dpkg -i packages-microsoft-prod.deb",
  "sudo apt update -y",
  "sudo apt install -y dotnet-sdk-8.0",

  "dotnet --version",

  # ---------------- BUILD APP ----------------
  "cd /home/SaiAzadmin/Product-Net && dotnet restore",
  "cd /home/SaiAzadmin/Product-Net && dotnet build -c Release --no-restore",
  "cd /home/SaiAzadmin/Product-Net && dotnet publish -c Release -o publish --no-build",

  "ls -la /home/SaiAzadmin/Product-Net/publish",

  # ---------------- ENV FILE ----------------
  "echo 'ConnectionStrings__DefaultConnection=Server=${azurerm_mysql_flexible_server.mysql.fqdn};Database=${var.db_user};User=${var.db_name};Password=${var.db_password};SslMode=Required' | sudo tee /etc/productnet.env",

  "sudo chmod 644 /etc/productnet.env",

  # ---------------- LOG DIRECTORY ----------------
  "sudo mkdir -p /var/log/productnet",
  "sudo chown SaiAzadmin:SaiAzadmin /var/log/productnet",

  # ---------------- SYSTEMD SERVICE ----------------
"sudo bash -c 'cat > /etc/systemd/system/productnet.service <<EOF\n[Unit]\nDescription=Product Net App\nAfter=network.target\n\n[Service]\nWorkingDirectory=/home/SaiAzadmin/Product-Net/publish\nExecStart=/usr/bin/dotnet /home/SaiAzadmin/Product-Net/publish/Product-Net.dll\nRestart=always\nRestartSec=10\nUser=SaiAzadmin\n\nEnvironmentFile=/etc/productnet.env\nEnvironment=ASPNETCORE_URLS=http://0.0.0.0:5001\nEnvironment=ASPNETCORE_ENVIRONMENT=Production\n\nSyslogIdentifier=productnet\n\n[Install]\nWantedBy=multi-user.target\nEOF'",
  # ---------------- START SERVICE ----------------
  "sudo systemctl daemon-reload",
  "sudo systemctl enable productnet",
  "sudo systemctl restart productnet",

  # ---------------- CHECK STATUS ----------------
  "sleep 5",
  "sudo systemctl status productnet --no-pager || true",
  "ss -tulnp | grep 5001 || echo 'API NOT RUNNING'",
  "echo 'Setup complete!'",

  # Install Prometheus
"wget https://github.com/prometheus/prometheus/releases/download/v2.53.0/prometheus-2.53.0.linux-amd64.tar.gz",
"tar xvf prometheus-2.53.0.linux-amd64.tar.gz",
"sudo mv prometheus-2.53.0.linux-amd64 /opt/prometheus",

# Create Prometheus config
"printf '%s\n' 'global:' '  scrape_interval: 15s' '' 'scrape_configs:' '  - job_name: \"node\"' '    static_configs:' '      - targets: [\"localhost:9100\"]' | sudo tee /opt/prometheus/prometheus.yml > /dev/null",

# Start Prometheus
"printf '%s\n' '[Unit]' 'Description=Prometheus' 'After=network.target' '' '[Service]' 'ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml' 'Restart=always' '' '[Install]' 'WantedBy=multi-user.target' | sudo tee /etc/systemd/system/prometheus.service > /dev/null",

"sudo systemctl daemon-reload",
"sudo systemctl enable prometheus",
"sudo systemctl start prometheus",

# Install Node Exporter
"wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz",
"tar xvf node_exporter-1.8.1.linux-amd64.tar.gz",
"sudo mv node_exporter-1.8.1.linux-amd64/node_exporter /usr/local/bin/",

# Node Exporter Service
"printf '%s\n' '[Unit]' 'Description=Node Exporter' 'After=network.target' '' '[Service]' 'ExecStart=/usr/local/bin/node_exporter' 'Restart=always' '' '[Install]' 'WantedBy=multi-user.target' | sudo tee /etc/systemd/system/node_exporter.service > /dev/null",

"sudo systemctl daemon-reload",
"sudo systemctl enable node_exporter",
"sudo systemctl start node_exporter",

# Install Grafana
"sudo apt-get install -y apt-transport-https software-properties-common wget",
"wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -",
"echo 'deb https://packages.grafana.com/oss/deb stable main' | sudo tee /etc/apt/sources.list.d/grafana.list",
"sudo apt-get update",
"sudo apt-get install -y grafana",

# Start Grafana
"sudo systemctl enable grafana-server",
"sudo systemctl start grafana-server"
      ]
    }
}

````markdown
# 🚀 Single Page 2-Tier Product Application

A modern **2-Tier Product Management Application** built using **.NET** and **MySQL**, deployed on **Microsoft Azure** with **Terraform** for Infrastructure as Code (IaC) and automated resource provisioning.

---

## 📖 Overview

This project demonstrates the deployment of a scalable product management application using a two-tier architecture:

- **Frontend & Backend Layer:** .NET Application
- **Database Layer:** MySQL Database
- **Infrastructure:** Azure Cloud
- **Provisioning:** Terraform

The application allows users to manage product information while showcasing cloud deployment and infrastructure automation best practices.

---

## 🏗️ Architecture

```text
┌─────────────────────┐
│   .NET Application  │
│  (Web/API Layer)    │
└──────────┬──────────┘
           │
           │
           ▼
┌─────────────────────┐
│    MySQL Database   │
│    (Data Layer)     │
└─────────────────────┘
````

### Azure Infrastructure

```text
Azure Resource Group
        │
        ├── Virtual Network (VNet)
        ├── Subnet
        ├── Network Security Group
        ├── Virtual Machine
        ├── Public IP
        └── MySQL Database
```

---

## ✨ Features

* Product Management System
* Single Page Application (SPA)
* .NET-based Application Layer
* MySQL Database Backend
* Infrastructure as Code using Terraform
* Automated Azure Resource Provisioning
* Scalable and Repeatable Deployments
* Cloud-Native Architecture

---

## 🛠️ Technology Stack

| Component              | Technology            |
| ---------------------- | --------------------- |
| Frontend/Backend       | .NET                  |
| Database               | MySQL                 |
| Cloud Platform         | Azure                 |
| Infrastructure as Code | Terraform             |
| Networking             | Azure VNet & NSG      |
| Compute                | Azure Virtual Machine |

---

## 📂 Project Structure

```text
.
├── app/
│   ├── source-code
│   └── configuration
│
├── terraform/
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
└── README.md
```

---

## 🚀 Deployment Workflow

### 1. Clone Repository

```bash
git clone <repository-url>
cd single-page-2tier-product-app
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate Configuration

```bash
terraform validate
```

### 4. Review Execution Plan

```bash
terraform plan
```

### 5. Deploy Infrastructure

```bash
terraform apply
```

### 6. Access Application

After deployment completes:

* Open the Azure VM Public IP or Application URL.
* Access the Product Management Application.
* Start managing products.

---

## ☁️ Azure Resources Created

* Resource Group
* Virtual Network (VNet)
* Subnet
* Network Security Group (NSG)
* Public IP Address
* Virtual Machine
* MySQL Database
* Required Network Associations

---

## 🔒 Security Considerations

* Restrict inbound ports using NSGs.
* Store sensitive values in Azure Key Vault or Terraform variables.
* Use strong database credentials.
* Enable backup and monitoring for production environments.

---

## 📈 Benefits of This Project

* Demonstrates Infrastructure as Code (IaC)
* Showcases Azure Cloud Deployment
* Simplifies Environment Provisioning
* Supports Consistent Deployments
* Reduces Manual Configuration Effort

---

## 🎯 Learning Outcomes

* Deploy .NET applications on Azure
* Configure MySQL database connectivity
* Build and manage a 2-tier architecture
* Automate infrastructure using Terraform
* Implement cloud networking and security concepts

---

## 📸 Project Highlights

✅ Single Page Application

✅ 2-Tier Architecture

✅ Azure Cloud Deployment

✅ Terraform Automation

✅ MySQL Integration

✅ Infrastructure as Code

---

## 👨‍💻 Author

**Saibaba Kola**

Cloud | Azure | Terraform | DevOps | Infrastructure Automation

```
```

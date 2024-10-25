# Terraform 
- [Terraform](#terraform)
  - [What is Terraform?](#what-is-terraform)
    - [What is Terraform used for?](#what-is-terraform-used-for)
  - [Why use Terraform? The Benefits](#why-use-terraform-the-benefits)
    - [Key Benefits of Terraform:](#key-benefits-of-terraform)
  - [Alternatives to Terraform](#alternatives-to-terraform)
  - [Who is Using Terraform in the Industry?](#who-is-using-terraform-in-the-industry)
  - [What is Orchestration in IaC?](#what-is-orchestration-in-iac)
    - [How Does Terraform Act as an Orchestrator?](#how-does-terraform-act-as-an-orchestrator)
  - [Best Practice: Supplying AWS Credentials to Terraform](#best-practice-supplying-aws-credentials-to-terraform)
    - [AWS Credentials Lookup Order in Terraform:](#aws-credentials-lookup-order-in-terraform)
    - [Best Practice to Supply AWS Credentials:](#best-practice-to-supply-aws-credentials)
    - [How AWS Credentials Should **Never** Be Passed to Terraform:](#how-aws-credentials-should-never-be-passed-to-terraform)
  - [Why Use Terraform for Different Environments (Production, Testing, etc.)](#why-use-terraform-for-different-environments-production-testing-etc)
    - [Benefits:](#benefits)
- [Steps to install terraform](#steps-to-install-terraform)
- [Launching an EC2 instance using terraform](#launching-an-ec2-instance-using-terraform)
  - [Adding a Security Group using Terraform](#adding-a-security-group-using-terraform)
  - [Adding Variables in Terraform](#adding-variables-in-terraform)
- [Push and Pull Configuration Management in IaC](#push-and-pull-configuration-management-in-iac)
  - [What is Push and Pull Configuration Management?](#what-is-push-and-pull-configuration-management)
    - [Push Configuration Management](#push-configuration-management)
    - [Pull Configuration Management](#pull-configuration-management)
  - [Which Tools Support Push and Pull?](#which-tools-support-push-and-pull)
  - [Does Terraform Use the Push or Pull Configuration?](#does-terraform-use-the-push-or-pull-configuration)
  - [Which is Better: Push or Pull Configuration Management?](#which-is-better-push-or-pull-configuration-management)
    - [Choosing Between Push and Pull:](#choosing-between-push-and-pull)
    - [Conclusion:](#conclusion)
- [Terraform GitHub Repository Automation](#terraform-github-repository-automation)
  - [Goal](#goal)
  - [Steps](#steps)
    - [Repository Link](#repository-link)
- [Two-Tier Azure Deployment Guide with Terraform](#two-tier-azure-deployment-guide-with-terraform)
  - [Prerequisites](#prerequisites)
  - [Steps](#steps-1)
    - [1. Initialize Terraform Configuration](#1-initialize-terraform-configuration)
    - [2. Define Provider](#2-define-provider)
    - [3. Configure Network Resources](#3-configure-network-resources)
      - [a) Define the Virtual Network and Subnets](#a-define-the-virtual-network-and-subnets)
    - [4. Configure Network Security Groups (NSGs)](#4-configure-network-security-groups-nsgs)
      - [a) App VM NSG](#a-app-vm-nsg)
      - [b) DB VM NSG](#b-db-vm-nsg)
    - [5. Create Network Interfaces](#5-create-network-interfaces)
    - [6. Create Virtual Machines](#6-create-virtual-machines)
      - [App VM](#app-vm)
      - [DB VM](#db-vm)
    - [7. Apply the Configuration](#7-apply-the-configuration)
    - [8. Once Created](#8-once-created)
  - [Notes](#notes)
  - [Clean Up](#clean-up)
  - [Blockers](#blockers)
- [Terraform Project Setup with Backend and Infrastructure Separation](#terraform-project-setup-with-backend-and-infrastructure-separation)
  - [Directory Structure](#directory-structure)
    - [Step 1: Backend Setup](#step-1-backend-setup)
      - [`backend/main.tf`](#backendmaintf)
    - [Step 2: Initialize and Deploy Backend](#step-2-initialize-and-deploy-backend)
    - [Step 3: Configure the Main Infrastructure Folder to Use the Backend](#step-3-configure-the-main-infrastructure-folder-to-use-the-backend)
      - [`infrastructure/main.tf`](#infrastructuremaintf)
    - [Step 4: Initialize and Deploy the Infrastructure](#step-4-initialize-and-deploy-the-infrastructure)
    - [Summary](#summary)

## What is Terraform?
* **Terraform** is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. 
* It allows users to define and provision data center infrastructure using a high-level configuration language called **HashiCorp Configuration Language (HCL)**. Good balance and understandble from machines and humans. 
* **Terraform** manages infrastructure across a wide range of service providers such as AWS, Azure, GCP, VMware, and even on-premise environments.
* **Terraform** is an orchestration tool (infrastructure provisioning tool - creates, deploys, manages and destroys the infrastructure).
* Terraform see infrastructure as **immutable**. 

### What is Terraform used for?
* Terraform is used to automate the process of creating, updating, and versioning infrastructure. 
* By using code, it allows teams to manage infrastructure resources such as virtual machines, networking, and storage in a declarative way. This ensures that infrastructure is always consistent across environments.

---

## Why use Terraform? The Benefits

### Key Benefits of Terraform:
1. **Infrastructure as Code (IaC)**: Treat infrastructure the same way as application code, using version control and best practices.
2. **Multi-Cloud**: Terraform is cloud-agnostic and can manage infrastructure across multiple cloud providers, making it a powerful tool for multi-cloud deployments.
3. **Declarative Syntax**: You define the end state of your infrastructure, and Terraform figures out the necessary steps to reach that state.
4. **Automation**: Automates repetitive manual tasks related to infrastructure management, reducing human error.
5. **Modular and Reusable Code**: Create reusable modules for infrastructure components, enabling easier scaling and management.
6. **State Management**: Terraform stores infrastructure states, which enables you to plan changes and apply only the necessary updates to your environment.
7. **Cloud Agnostic**: Can deploy to any cloud provider because it uses different cloud providers. Each provider maintains their own plugins (e.g. Azure has an Azure plugin in Terraform that will interface with the API of Azure).  
8. **Free?**: We can use it for free commercially. Terraform cannot be used to create a competing product.
9. **Open-Source and Easy to use**. 

---

## Alternatives to Terraform
There are several alternatives to Terraform in the Infrastructure as Code (IaC) space, including:

1. **AWS CloudFormation**: AWS-specific tool for provisioning infrastructure on AWS.
2. **Ansible**: Primarily a configuration management tool but can also manage infrastructure provisioning.
3. **Pulumi**: Similar to Terraform, but allows you to write infrastructure code using general-purpose programming languages (e.g., TypeScript, Python).
4. **Chef/Puppet**: Configuration management tools that can manage infrastructure but are more focused on provisioning applications and environments.
5. **Google Cloud Deployment Manager**: Google Cloud-specific infrastructure provisioning tool.

---

## Who is Using Terraform in the Industry?
Terraform is widely adopted across industries, from small startups to large enterprises, due to its flexibility and multi-cloud capabilities. Some of the industries using Terraform include:

- **Technology companies** (e.g., Slack, Uber, and Shopify) for managing cloud infrastructure.
- **Financial services** for secure and scalable infrastructure deployment.
- **Retail and E-commerce** for provisioning dynamic infrastructure at scale.
- **Media and Entertainment** for managing large-scale content delivery systems.

---

## What is Orchestration in IaC?
* **Orchestration** in Infrastructure as Code refers to the process of coordinating and managing multiple components of infrastructure (e.g., networks, servers, databases) to work together harmoniously. 
* It involves defining the relationships and dependencies between various resources and automating their provisioning and configuration.

### How Does Terraform Act as an Orchestrator?
Terraform acts as an orchestrator by:
1. Defining the desired end state of your infrastructure in code.
2. Automatically determining the correct order in which to provision, modify, or destroy resources, respecting dependencies (e.g., creating a database before deploying an application).
3. Applying changes in a controlled and predictable way, using its built-in plan and apply workflow.

---

## Best Practice: Supplying AWS Credentials to Terraform

### AWS Credentials Lookup Order in Terraform:
Terraform checks for AWS credentials in the following order of precedence (if it can't find from the one it will check the nexxt one on the list):
1. **Environment Variables**: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
    * You would need to set up system variables under **Edit the system environment variables**.
2. **AWS Credentials File**: Located at `~/.aws/credentials`.
3. **Instance Profile**: For EC2 instances running in AWS with an IAM role attached.
4. **Explicit Access in Terraform Config**: Credentials provided directly in the Terraform configuration file (not recommended).

### Best Practice to Supply AWS Credentials:
The recommended approach for securely supplying AWS credentials is through **environment variables** or by using **AWS IAM roles** (for EC2 instances). These methods reduce the chances of exposing sensitive credentials.

1. **Use Environment Variables**: Use `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as environment variables to provide access.
   - Example:
     ```bash
     export AWS_ACCESS_KEY_ID="your-access-key-id"
     export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
     ```

2. **Use AWS Profiles**: Use profiles defined in the AWS credentials file (`~/.aws/credentials`) and reference them using the `profile` parameter in Terraform.
   - Example:
     ```hcl
     provider "aws" {
       profile = "my-aws-profile"
     }
     ```

3. **Use IAM Roles** if you are using a cloud resource: For EC2 instances, assign IAM roles with the necessary permissions. Terraform will automatically detect and use the role without the need for explicit credentials.

### How AWS Credentials Should **Never** Be Passed to Terraform:
- **Do not hard-code credentials** directly in the Terraform files (`.tf` files). This can lead to accidental exposure in version control systems like GitHub.
- **Avoid committing `~/.aws/credentials`** or environment variables with credentials into source control.

---

## Why Use Terraform for Different Environments (Production, Testing, etc.)
* Using Terraform to manage multiple environments (such as **production**, **staging**, and **testing**) allows you to maintain consistent infrastructure across these environments while also adapting to their unique requirements.
* Developers using different environments will cause problems. Having a consistent environment and then that matching environment is used throughout the different environments. 
    * All the dependencies should match. 
    * **Production environment** needs to be scalable so you have more load than **Testing**. 

### Benefits:
1. **Consistency**: Ensures that each environment is created with the same infrastructure code, reducing drift and errors.
2. **Separation of Concerns**: You can use different **Terraform workspaces** or separate configuration files for each environment, ensuring that changes to one environment do not affect others.
3. **Version Control**: You can track infrastructure changes for each environment using a version control system (e.g., Git).
4. **Testing**: Test infrastructure changes in staging or testing environments before applying them to production.

By using Terraform, organizations can automate the provisioning and teardown of environments, enabling faster deployment cycles and reducing human error.

---

# Steps to install terraform 
1) Go on the terraform website and select the **Windows AMD64**.
2) This will download as a zip you can then extract this and add it to a `C:\my-cmd-line-tools`.
3) Search on the search below **Edit System Environment Variables** and add a PATH env variable with the path to the terraform file. 

---
# Launching an EC2 instance using terraform

1. Make environment variables as `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and store them under **System variables**.
2. Setup your `.gitignore` and add files to ensure that credentials are not being pushed to GitHub. 
3. Create a `main.tf` file this is where you will write your script to deploy the instance. In this script you want to include the following: [Terraform script to launch EC2 instance](main.tf).
4. When you have at least the `provider` in your script you can use `terraform init` in a new git bash window once you have `cd` to the correct directory.
5. Once you have completed the script ([Terraform script to launch EC2 instance](main.tf)). Then you can run `terraform plan` and `terraform apply`. 
6. You can check this and see if your instance has been created on **AWS**. 
7. To terminate this instance you can use: `terraform destroy`.   

## Adding a Security Group using Terraform
* [Terraform script to add a security group.](create-aws-sg/main.tf)

## Adding Variables in Terraform
* This is the format of the variables and it should be stored in a separate folder named `variable.tf` and in your `main.tf` you call the variable as `var.<variable-name>`:
```hcl
variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "eu-west-1"
}
```

---

# Push and Pull Configuration Management in IaC

## What is Push and Pull Configuration Management?

* In **Infrastructure as Code (IaC)**, configuration management describes how system configurations are applied and maintained on servers. 
* There are two primary models for configuration management: **push** and **pull**.

### Push Configuration Management
* In the push model, a central server or control system sends (or "pushes") the desired configurations to the target machines (nodes). 
* The admin or orchestration tool directly pushes out changes to the systems that need configuration updates. 

- **How it works**: The administrator initiates the process manually or via automation, and the configurations are deployed from a central server.
- **Use cases**: Push is often used for smaller-scale environments or environments where control over the configuration deployment timing is critical.

### Pull Configuration Management
* In the pull model, the target nodes are responsible for checking into a central server, retrieving (or "pulling") their configurations, and applying them. 
* The configurations live on a central repository, and the nodes autonomously pull updates periodically.

- **How it works**: Agents running on each node communicate with the central server to fetch the latest configurations.
- **Use cases**: The pull model is often used in larger-scale environments where consistent state is critical and regular checks for updates can ensure consistency.

## Which Tools Support Push and Pull?

Various tools in the DevOps ecosystem support push and pull models:

- **Push-based Tools**:
  - **Ansible**: An open-source automation platform that works via SSH to push configurations to target nodes.
  - **SaltStack** (can also be pull-based): Can be configured to operate in push mode where configurations are sent from a central control node.

- **Pull-based Tools**:
  - **Puppet**: Uses agents on nodes to pull configurations from a central Puppet Master.
  - **Chef**: Nodes pull configurations from a Chef server and apply them locally.
  - **SaltStack**: Can operate in pull mode with minions fetching updates from a Salt master.
  
## Does Terraform Use the Push or Pull Configuration?

* Terraform uses a **push-based model** for applying infrastructure changes. When you run commands like `terraform apply`, Terraform executes a plan from your local machine or a CI/CD pipeline and **pushes** the necessary infrastructure changes to the respective cloud providers (AWS, Azure, GCP, etc.). 
* Terraform is not agent-based, so it doesn't rely on nodes to pull configurations.

## Which is Better: Push or Pull Configuration Management?

The answer depends on your use case:

- **Push Configuration Advantages**:
  - More control over deployment timing, useful for smaller environments or those requiring fine-grained deployment control.
  - Easier for immediate, on-demand updates.

- **Pull Configuration Advantages**:
  - Ideal for larger environments where nodes should autonomously manage their configurations.
  - Ensures consistency as nodes regularly check for updates and pull changes.

### Choosing Between Push and Pull:
- **For smaller environments**: Push may be simpler and more straightforward.
- **For large, complex environments**: Pull models are generally better because they ensure continuous consistency, especially when infrastructure scales.

### Conclusion:
* There is no universally "better" approach—it depends on the complexity, scale, and requirements of your infrastructure. 
* In some cases, you may even combine both models depending on the specific use cases.


# Terraform GitHub Repository Automation

## Goal
Automate the creation of a GitHub repository using Terraform.

## Steps

1. Create a Personal Access Token (PAT) on GitHub with necessary scopes.
   1. Go to **Settings** > **Developer Settings** > **Create Classic Token** > **Select repo**.
   2. This will generate the token. Make sure to never hardcode this.  
2. Store the PAT in environment variables or in `variable.tf`.
3. Configure Terraform with a `main.tf` file to create a GitHub repository.
4. Create a `.gitignore` file to ignore sensitive files.
5. Initialize and apply the Terraform configuration.
6. Verify the repository creation on GitHub.

### Repository Link
[tech264-terraform-create-github-repo](https://github.com/your_username/tech264-terraform-create-github-repo)


# Two-Tier Azure Deployment Guide with Terraform

This guide outlines the steps for deploying a two-tier Azure setup using Terraform. The setup includes a Virtual Network (VNet) with two subnets, one for the application VM and one for the database VM, along with configured Network Security Groups (NSGs) to manage access.

## Prerequisites
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured. 
  - Make sure you use the command prompt to login using `az login`, once you have installed the `AZ CLI`
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed.
- An existing Azure Resource Group - which is `tech264`

## Steps

### 1. Initialize Terraform Configuration
1. Create a new folder for your Terraform project and navigate into it.
   ```bash
   mkdir tech264-tf-azure && cd tech264-tf-azure
   ```
2. Create a `main.tf` file to hold the Terraform configuration.

### 2. Define Provider
In `main.tf`, specify the Azure provider:
```hcl
provider "azurerm" {
  features {}
}
```

### 3. Configure Network Resources
#### a) Define the Virtual Network and Subnets
Add the following block to `main.tf` to create a Virtual Network with two subnets.

```hcl
# Reference an existing resource group
data "azurerm_resource_group" "main" {
  name = "tech264" # Replace with the actual name of your resource group
  location            = "UK South"
  resource_group_name = "your-existing-rg-name"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_virtual_network.main_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_virtual_network.main_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}
```

### 4. Configure Network Security Groups (NSGs)
#### a) App VM NSG
Allow ports 22, 80, and 3000.

```hcl
resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Port-3000"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3000
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

#### b) DB VM NSG
Allow only SSH and MongoDB access, and deny everything else.

```hcl
resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-MongoDB"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 27017
    source_address_prefix      = "10.0.1.0/24"  # App Subnet CIDR
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

### 5. Create Network Interfaces
Create NICs for each VM.

```hcl
resource "azurerm_network_interface" "app_nic" {
  name                = "app-nic"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name

  ip_configuration {
    name                          = "app-ip-config"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "db_nic" {
  name                = "db-nic"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name

  ip_configuration {
    name                          = "db-ip-config"
    subnet_id                     = azurerm_subnet.db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
```
* After creating the **NSG** and **NIC**, you would need to create an association between these:
```hcl 
resource "azurerm_network_interface_security_group_association" "db_nic_2_nsg" {
  network_interface_id      = azurerm_network_interface.db_nic.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}

resource "azurerm_network_interface_security_group_association" "app_nic_2_nsg" {
  network_interface_id      = azurerm_network_interface.app_nic.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}
```
### 6. Create Virtual Machines
* Provision both VMs with NSGs, SSH keys, and Ubuntu 22.04. Or you can use an image that you have already created. For example the images that were created for the `App VM` and `DB VM` with the user data already added in. All you need to do is add user data for the app to run and include the the `private-ip` for the DB.

#### App VM
```hcl
resource "azurerm_linux_virtual_machine" "app_vm" {
  name                = "app-vm"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.app_nic.id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/your_ssh_key.pub")
  }
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-pro-azure"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
```
* Referencing your own image: 
``` hcl
source_image_id = "/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourceGroups/tech264/providers/Microsoft.Compute/images/tech264-priyan-db-image-readyy-to-run"
```

#### DB VM
```hcl
resource "azurerm_linux_virtual_machine" "db_vm" {
  name                = "db-vm"
  location            = azurerm_virtual_network.main_vnet.location
  resource_group_name = azurerm_virtual_network.main_vnet.resource_group_name
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.db_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/your_ssh_key.pub")
  }
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-pro-azure"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
```

### 7. Apply the Configuration
Initialize and apply the configuration.

```bash
terraform init
terraform apply
```

### 8. Once Created
Check the public ip by searching on the browser and check the `/posts` page is working.

## Notes
- Replace `"your-existing-rg-name"` with the name of your resource group.
- Adjust paths for SSH keys as necessary.

## Clean Up
To destroy resources created by this deployment, run:

```bash
terraform destroy
```

## Blockers
* Make sure to create an association with your NSG and NIC. 
* Create a **Public IP Address**. 
* You can create the infrastructure with minimal code and then keep adding extra components to visualise the new additions. 
* Create `variable.tf` for better structure. 
* Making a `.gitignore` file in each folder. Therefore you are not pushing any credentials to your GitHub repo. 


# Terraform Project Setup with Backend and Infrastructure Separation

This guide outlines the steps to create a Terraform project that separates the backend configuration (for state management) from the main infrastructure deployment.

## Directory Structure

```bash
/terraform-project
  ├── /backend
  │    └── main.tf (contains backend configuration)
  └── /infrastructure
       ├── main.tf (contains main architecture for deploying the app)
       └── variables.tf (optional, contains input variables)
```

### Step 1: Backend Setup

In the `backend/` folder, create a `main.tf` file to define the Azure storage account for storing the Terraform state file. Backend can have a `variable.tf` file. 

#### `backend/main.tf`

```hcl
provider "azurerm" {
  features {}
  use_cli                         = true
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}

# Reference an existing resource group
data "azurerm_resource_group" "main" {
  name = "tech264" # Replace with the actual name of your resource group
}


resource "azurerm_storage_account" "backend_sa" {
  name                     = "tfpriyanstorageacct" # Storage account name must be unique
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  tags = {Name="priyan"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend_sa.name
  container_access_type = "private"
}
```

### Step 2: Initialize and Deploy Backend

1. Navigate to the `backend` folder:
   ```bash
   cd terraform-project/backend
   ```

2. Initialize and apply the backend setup:
   ```bash
   terraform init
   terraform apply
   ```

   This will create the Azure Storage Account and container for storing the state files.

3. After applying, take note of the following values (you can use `output` blocks if needed):
   - **Storage Account Name**: `azurerm_storage_account.backend_sa.name`
   - **Container Name**: `azurerm_storage_container.tfstate.name`

### Step 3: Configure the Main Infrastructure Folder to Use the Backend

Now that the backend is set up, configure the `infrastructure` folder to use this `backend` for its state management.

#### `infrastructure/main.tf`
This will include our script from the Two-Tier Deployment. The addition is at the top where we have referenced our `backend`. 
```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "tech264"
    storage_account_name  = "tfpriyanstorageacct"
    container_name        = "tfstate"
    key                   = "infrastructure/terraform.tfstate" # You can organize state files by folder
  }
}

provider "azurerm" {
  features {}
  use_cli                         = true
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}


# Reference an existing resource group
data "azurerm_resource_group" "main" {
  name = "tech264" # Replace with the actual name of your resource group
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "terraform-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

# Create the Application Subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create the Database Subnet
resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create NSG for App VM
resource "azurerm_network_security_group" "app_nsg" {
  name                = "priyan-app-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  # Inbound security rules
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Port-3000"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3000
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create NSG for DB VM
resource "azurerm_network_security_group" "db_nsg" {
  name                = "priyan-db-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  # Inbound security rules
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-MongoDB"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 27017
    source_address_prefix      = "10.0.2.0/24" # App Subnet CIDR block
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Association with NSG and NIC
resource "azurerm_network_interface_security_group_association" "db_nic_2_nsg" {
  network_interface_id      = azurerm_network_interface.db_nic.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}

resource "azurerm_network_interface_security_group_association" "app_nic_2_nsg" {
  network_interface_id      = azurerm_network_interface.app_nic.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}
# Create Public IP for App VM
resource "azurerm_public_ip" "app_public_ip" {
  name                = "priyan-app-public-ip"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Static"
}

# Create NIC for App VM
resource "azurerm_network_interface" "app_nic" {
  name                = "priyan-app-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "app-ip-config"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.app_public_ip.id
  }
}

# Create NIC for DB VM
resource "azurerm_network_interface" "db_nic" {
  name                = "priyan-db-nic"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "db-ip-config"
    subnet_id                     = azurerm_subnet.db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create the Application VM
resource "azurerm_linux_virtual_machine" "app_vm" {
  name                = "priyan-app-vm-from-tf"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/tech264-priyan-az-key.pub") # Path to your SSH public key
  }

  network_interface_ids = [
    azurerm_network_interface.app_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }

  source_image_id = "/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourceGroups/tech264/providers/Microsoft.Compute/images/tech264-priyan-app-vm-image-readyy-to-run"

  user_data = base64encode(<<-EOF
  #!/bin/bash
  export DB_HOST="mongodb://10.0.3.4:27017/posts"

  echo "Change directory to app"
  cd repo/app

  pm2 stop all
  echo "start"
  pm2 start app.js
  echo "App started with pm2"
  EOF
  )
  
  depends_on = [azurerm_linux_virtual_machine.db_vm]
}

# Create the Database VM
resource "azurerm_linux_virtual_machine" "db_vm" {
  name                = "priyan-db-vm-from-tf"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/tech264-priyan-az-key.pub") # Path to your SSH public key
  }

  network_interface_ids = [
    azurerm_network_interface.db_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 30
  }

  source_image_id = "/subscriptions/cd36dfff-6e85-4164-b64e-b4078a773259/resourceGroups/tech264/providers/Microsoft.Compute/images/tech264-priyan-db-image-readyy-to-run"
}


```

Make sure to replace the `resource_group_name`, `storage_account_name`, `container_name`, and `key` with the actual names created in the backend.

### Step 4: Initialize and Deploy the Infrastructure

1. Navigate to the `infrastructure` folder:
   ```bash
   cd ../infrastructure
   ```

2. Initialize the Terraform configuration:
   ```bash
   terraform init
   ```

   During this step, Terraform will connect to the backend configured in the `backend` folder.

3. Apply the infrastructure:
   ```bash
   terraform apply
   ```
* But you won't need to if you have already applied it previously. In that case just complete steps 1 and 2 and that should initialise the backend for your infrastructure. 

* The state file will be stored in the Azure Blob Storage defined in the `backend` configuration.

---

### Summary

- **Backend folder**: Contains the configuration to set up Azure Blob Storage for the Terraform state file.
- **Infrastructure folder**: Contains the infrastructure deployment that uses the backend for state file management.
- **Separation of concerns**: This setup allows you to independently manage your backend and infrastructure, improving organization and maintainability.

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

In the `backend/` folder, create a `main.tf` file to define the Azure storage account for storing the Terraform state file.

#### `backend/main.tf`

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "tf-backend-rg"
  location = "UK South" # Adjust the region accordingly
}

resource "azurerm_storage_account" "backend_sa" {
  name                     = "tfbackendstorageacct"  # Storage account name must be unique
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
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

Now that the backend is set up, configure the `infrastructure` folder to use this backend for its state management.

#### `infrastructure/main.tf`

```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "tf-backend-rg"
    storage_account_name  = "tfbackendstorageacct"
    container_name        = "tfstate"
    key                   = "infrastructure/terraform.tfstate" # You can organize state files by folder
  }
}

provider "azurerm" {
  features {}
}

# Define your infrastructure resources here, for example:
resource "azurerm_resource_group" "app_rg" {
  name     = "app-rg"
  location = "UK South"
}

# Add other infrastructure components such as VMs, networking, etc.
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

   The state file will be stored in the Azure Blob Storage defined in the `backend` configuration.

---

### Summary

- **Backend folder**: Contains the configuration to set up Azure Blob Storage for the Terraform state file.
- **Infrastructure folder**: Contains the infrastructure deployment that uses the backend for state file management.
- **Separation of concerns**: This setup allows you to independently manage your backend and infrastructure, improving organization and maintainability.

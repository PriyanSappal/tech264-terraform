# Create an EC2 instance
# AWS_ACCESS_KEY = xxxx MUST NEVER DO THIS
# AWS_SECRET_KEY = xxxx MUST NEVER DO THIS
# Syntax often used in HCL is key = value
# Where to create - provide the provider

provider "aws" {
  # which region to use to create infrastructure
  region = var.aws_region
}

# Create a Security Group
resource "aws_security_group" "app_sg" {
  name        = "tech264-priyan-tf-app-sg-2"
  description = "Allow SSH and HTTP traffic"

  # Inbound rules
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_blocks] # Allow SSH from anywhere; restrict for security.
  }

  ingress {
    description = "Allow port 3000 from all"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_blocks] # Allow access from anywhere
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr_blocks] # Allow HTTP traffic from anywhere
  }


  tags = {
    Name = "tech264-priyan-tf-allow-port-22-3000-80-2"
  }
}

# Which service/resources to create
resource "aws_instance" "app_instance" {
  # Which AMI ID ami-0c1c30571d2dae5c9 (for ubuntu 22.04 lts)
  ami = var.ami_id
  # What type of instance to launch - t2.micro
  instance_type = var.instance_type
  # Add a public IP to this instance
  associate_public_ip_address = true
  # Security group
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  # SSH Key pair 
  key_name = var.key_name
  # Name the service/resource we create
  tags = {
    Name = "tech264-priyan-tf-app-instance"
  }
}


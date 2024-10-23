provider "aws" {
  # which region to use to create infrastructure
  region = "eu-west-1"
}
# Create a Security Group
resource "aws_security_group" "app_sg" {
  name        = "tech264-priyan-tf-app-sg"
  description = "Allow SSH and HTTP traffic"

  # Inbound rules
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere; restrict for security.
  }

  ingress {
    description = "Allow port 3000 from all"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
  }


  tags = {
    Name = "tech264-priyan-tf-allow-port-22-3000-80"
  }
}
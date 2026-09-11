terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
}

# =========================================================
# JENKINS SERVER NETWORK
# =========================================================

resource "aws_vpc" "devops_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "enterprise-devops-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "enterprise-devops-public-subnet"
  }
}

resource "aws_internet_gateway" "devops_igw" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "enterprise-devops-internet-gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_igw.id
  }

  tags = {
    Name = "enterprise-devops-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# =========================================================
# JENKINS SECURITY GROUP
# =========================================================

resource "aws_security_group" "devops_sg" {
  name        = "enterprise-devops-sg"
  description = "Security group for DevOps project"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["122.171.21.97/32"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Enterprise DevOps Application"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
  Name = "enterprise-devops-security-group"
  }
} 

# =========================================================
# EXISTING APPLICATION SERVER NETWORK
# =========================================================

data "aws_subnet" "app_subnet" {
  id = "subnet-04baae7b5b5863d4b"
}

data "aws_security_group" "app_sg" {
  id = "sg-0a31254edc692a4b6"
}

# =========================================================
# JENKINS SERVER
# =========================================================

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.small"

  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.devops_sg.id]
  associate_public_ip_address = true

  key_name = "terraform-key"

  tags = {
    Name = "Jenkins-Server"
  }
}

# =========================================================
# APPLICATION SERVER
# =========================================================

resource "aws_instance" "app_server" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.small"

  subnet_id                   = data.aws_subnet.app_subnet.id
  vpc_security_group_ids      = [data.aws_security_group.app_sg.id]
  associate_public_ip_address = true

  key_name = "terraform-key"

  tags = {
    Name = "Enterprise-DevOps-App-Server"
  }
}

# =========================================================
# OUTPUTS
# =========================================================

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "app_server_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "app_server_url" {
  value = "http://${aws_instance.app_server.public_ip}:8081"
}

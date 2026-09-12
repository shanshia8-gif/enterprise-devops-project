# Enterprise DevOps Lifecycle Automation on AWS

## Project Overview

This project demonstrates an end-to-end DevOps workflow for deploying a containerized web application on AWS.

The project combines **Terraform, AWS EC2, Jenkins, Docker, NGINX, Linux, and GitHub** to demonstrate Infrastructure as Code (IaC), continuous integration, containerization, and automated application deployment.

Terraform is used to provision the AWS infrastructure, while Jenkins retrieves the application source code from GitHub, builds the Docker image, and deploys the application as a Docker container on the application server.

---

## Architecture

```text
                    Developer
                        |
                        v
                  GitHub Repository
                        |
                        v
                Jenkins CI/CD Server
                        |
                        | Checkout
                        v
                  Build Docker Image
                        |
                        v
              Application Server
                        |
                        v
                Docker Container
                        |
                        v
                  NGINX Web Server
                        |
                        v
                Web Application
```

### AWS Infrastructure

```text
                         AWS
                          |
                +---------+---------+
                |                   |
                v                   v
          Jenkins EC2          Application EC2
                |                   |
                |                   |
             Jenkins              Docker
                                    |
                                  NGINX
                                    |
                              Web Application
```

---

## Technology Stack

| Technology       | Purpose                                      |
| ---------------- | -------------------------------------------- |
| AWS EC2          | Hosts the Jenkins and application servers    |
| AWS VPC          | Provides isolated network infrastructure     |
| AWS Subnet       | Provides network placement for EC2 resources |
| Internet Gateway | Provides internet connectivity               |
| Security Group   | Controls inbound and outbound traffic        |
| Terraform        | Infrastructure as Code                       |
| Jenkins          | CI/CD automation                             |
| Docker           | Application containerization                 |
| NGINX            | Web server                                   |
| GitHub           | Source code management                       |
| Linux            | Server operating system                      |

---

## Project Structure

```text
enterprise-devops-project/
│
├── Dockerfile
├── Jenkinsfile
├── index.html
├── README.md
│
└── terraform/
    ├── main.tf
    ├── providers.tf
    ├── variables.tf
    ├── outputs.tf
    └── .terraform.lock.hcl
```

---

# Infrastructure Provisioning with Terraform

Terraform is used to define and provision the AWS infrastructure required for the project.

The infrastructure includes:

* AWS VPC
* Public subnet
* Internet Gateway
* Route table
* Route table association
* Security Group
* Jenkins EC2 instance
* Application EC2 instance

Terraform follows an Infrastructure as Code approach, allowing the infrastructure configuration to be maintained in GitHub.

## Terraform Configuration

The project uses:

* Terraform `>= 1.5.0`
* AWS provider `~> 6.0`
* AWS region `ap-south-1`
* EC2 instance type `t3.small`
* Existing EC2 key pair `terraform-key`

## Terraform Workflow

```text
Terraform Configuration
        |
        v
terraform init
        |
        v
terraform validate
        |
        v
terraform plan
        |
        v
terraform apply
        |
        v
AWS Infrastructure
```

### Initialize Terraform

```bash
cd terraform
terraform init
```

### Validate the configuration

```bash
terraform validate
```

### Review infrastructure changes

```bash
terraform plan
```

### Apply infrastructure

```bash
terraform apply
```

> `terraform apply` should only be executed after reviewing the Terraform plan.

---

# Jenkins CI/CD Pipeline

Jenkins is used to automate the application deployment process.

The Jenkins pipeline retrieves the source code from GitHub and performs the Docker build and deployment process.

## Pipeline Workflow

```text
GitHub
   |
   v
Jenkins
   |
   v
Checkout Source Code
   |
   v
Build Docker Image
   |
   v
Stop Existing Container
   |
   v
Remove Existing Container
   |
   v
Run New Docker Container
   |
   v
NGINX Application
```

## Current Jenkins Pipeline Stages

1. Checkout source code from GitHub
2. Build Docker image
3. Stop the existing Docker container
4. Remove the existing Docker container
5. Start the new Docker container

This provides an automated deployment workflow whenever the Jenkins pipeline is executed.

---

# Docker Containerization

The web application is packaged into a Docker image.

The Docker image uses **NGINX** as the web server and serves the application's static web content.

## Build Docker Image

```bash
docker build -t enterprise-devops:latest .
```

## Run Docker Container

```bash
docker run -d \
  --name enterprise-devops-container \
  -p 8081:80 \
  enterprise-devops:latest
```

The container maps:

```text
EC2 Port 8081
      |
      v
Container Port 80
      |
      v
NGINX
```

The application can therefore be accessed through:

```text
http://<APPLICATION-SERVER-PUBLIC-IP>:8081
```

---

# Application Deployment

The application is deployed to an AWS EC2 application server.

The deployment flow is:

```text
Developer
    |
    v
GitHub
    |
    v
Jenkins
    |
    v
Docker Build
    |
    v
Docker Container
    |
    v
NGINX
    |
    v
Web Application
```

---

# Network Configuration

The Terraform configuration creates a VPC with the following network design:

```text
VPC
10.0.0.0/16
    |
    +-- Public Subnet
        10.0.1.0/24
             |
             +-- Jenkins EC2
```

The application server uses an existing subnet and security group referenced through Terraform data sources.

---

# Security Group Configuration

The project uses AWS Security Groups to control network traffic.

The Jenkins server security group includes access for:

| Port | Purpose     |
| ---: | ----------- |
|   22 | SSH         |
| 8080 | Jenkins     |
|   80 | HTTP        |
| 8081 | Application |

For learning and demonstration purposes, some services are exposed publicly.

## Production Security Improvements

For a production environment, the following improvements should be implemented:

* Restrict SSH access to trusted IP addresses
* Restrict Jenkins access using approved networks or a load balancer
* Avoid unnecessary public exposure
* Use IAM roles instead of long-term AWS credentials
* Store secrets in Jenkins Credentials Manager or AWS Secrets Manager
* Apply least-privilege IAM policies
* Enable HTTPS
* Use private subnets for application servers where appropriate
* Add monitoring and centralized logging

---

# Application Access

After successful deployment, the application can be accessed using:

```text
http://<APPLICATION-SERVER-PUBLIC-IP>:8081
```

Jenkins can be accessed using:

```text
http://<JENKINS-PUBLIC-IP>:8080
```

The exact IP addresses are generated by Terraform outputs after infrastructure provisioning.

---

# Project Outcome

This project demonstrates practical implementation of:

* AWS cloud infrastructure
* Infrastructure as Code using Terraform
* AWS VPC networking
* EC2 provisioning
* Security Group configuration
* Jenkins CI/CD
* Docker containerization
* NGINX web serving
* GitHub source-code management
* Automated application deployment

The project demonstrates how multiple DevOps tools can be integrated into a single deployment workflow.

---

# Future Enhancements

The following features can be added in future iterations:

* Docker image publishing to Docker Hub or Amazon ECR
* Automated testing
* Container security scanning using Trivy
* Ansible-based server configuration
* Kubernetes deployment
* Prometheus and Grafana monitoring
* Centralized logging
* HTTPS with SSL/TLS
* GitHub webhook-triggered Jenkins builds
* Blue-Green or Rolling deployment
* AWS Application Load Balancer
* Auto Scaling
* AWS IAM role-based access

These are listed as future enhancements and are not represented as currently implemented features.

---

# Author

**Shanshi A**

GitHub: https://github.com/shanshia8-gif

---

# Conclusion

The Enterprise DevOps Lifecycle Automation project demonstrates an end-to-end workflow using:

**GitHub → Jenkins → Docker → NGINX → AWS EC2**

Terraform provides Infrastructure as Code for the AWS environment, Jenkins automates the application deployment workflow, Docker provides containerization, and NGINX serves the web application.

The project provides a practical foundation for understanding how DevOps tools work together to automate infrastructure and application deployment.

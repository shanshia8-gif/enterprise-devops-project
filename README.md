# Enterprise DevOps Project

## 🚀 Project Overview

This project demonstrates an end-to-end DevOps implementation for deploying a web application using Terraform, AWS EC2, Jenkins, Docker, and NGINX.

The project automates infrastructure provisioning and application deployment using Infrastructure as Code (IaC) and a CI/CD pipeline.

Terraform provisions the AWS infrastructure, while Jenkins automates the process of building a Docker image and deploying the application as a Docker container running NGINX.

---

## 🏗️ Architecture

```text
Developer
    │
    ▼
GitHub Repository
    │
    ▼
Jenkins CI/CD Pipeline
    │
    ▼
Build Docker Image
    │
    ▼
Docker Container
    │
    └── NGINX Web Server
    │
    ▼
AWS EC2 Instance
```

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| AWS EC2 | Cloud infrastructure for hosting the application |
| Terraform | Infrastructure as Code (IaC) |
| Jenkins | Continuous Integration and Continuous Deployment |
| Docker | Application containerization |
| NGINX | Web server for serving the application |
| GitHub | Source code management |
| Linux | Operating system environment |

## 📂 Project Structure

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
    ├── variables.tf
    └── outputs.tf
```

## ⚙️ Infrastructure Provisioning with Terraform

Terraform is used to provision AWS infrastructure including:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance

### Terraform Commands

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

## 🐳 Docker Containerization

The application is containerized using Docker. The Docker image uses NGINX to serve the static web application.

### Build the Docker image

```bash
docker build -t enterprise-devops:latest .
```

### Run the Docker container

```bash
docker run -d --name enterprise-devops-container -p 8081:80 enterprise-devops:latest
```

The application will be available at:

```text
http://<EC2-PUBLIC-IP>:8081
```

## 🔄 Jenkins CI/CD Pipeline

Jenkins automates the application deployment process.

The pipeline performs the following stages:

1. Checkout source code from GitHub
2. Build the Docker image
3. Stop the existing container
4. Remove the previous container
5. Deploy the new container

## 🔁 CI/CD Workflow

```text
Developer Pushes Code
        │
        ▼
GitHub Repository
        │
        ▼
Jenkins Pipeline
        │
        ▼
Docker Image Built
        │
        ▼
Old Container Stopped
        │
        ▼
Old Container Removed
        │
        ▼
New Container Deployed
        │
        ▼
Application Available
```

## 🔐 Security Considerations

This project is designed for learning and demonstration purposes.

For production environments, recommended improvements include:

- Restrict SSH access to trusted IP addresses
- Avoid exposing SSH to `0.0.0.0/0`
- Restrict Jenkins access to authorized users
- Use IAM roles instead of storing credentials
- Store secrets securely using Jenkins Credentials Manager or AWS Secrets Manager
- Apply the principle of least privilege
- Enable HTTPS for production workloads

## 🌐 Application Access

After successful deployment, access the application using:

```text
http://<EC2-PUBLIC-IP>:8081
```

Make sure port **8081** is allowed in the AWS Security Group.

## 📊 Project Outcome

This project demonstrates practical experience with:

- Infrastructure provisioning using Terraform
- AWS cloud infrastructure
- CI/CD automation using Jenkins
- Application containerization using Docker
- Web application hosting using NGINX
- Automated deployment workflows
- Git-based source code management

The project demonstrates how DevOps tools can be integrated to automate infrastructure provisioning and application deployment.

## 🚀 Future Enhancements

Possible future improvements include:

- Automated Jenkins and Docker installation using Terraform `user_data`
- Automated testing
- Container security scanning with Trivy
- Docker image storage using Docker Hub or Amazon ECR
- Blue-Green deployment
- HTTPS implementation
- Monitoring using Prometheus and Grafana
- Centralized logging
- Kubernetes deployment
- GitHub webhook integration

## 👩‍💻 Author

**Shanshi A**

GitHub: https://github.com/shanshia8-gif

## ⭐ Conclusion

This project demonstrates an end-to-end DevOps workflow using **Terraform, AWS EC2, Jenkins, Docker, NGINX, and GitHub**.

Terraform provisions the cloud infrastructure, while Jenkins automates the application build and deployment process. Docker provides consistent application deployment through containerization, and NGINX serves the web application.

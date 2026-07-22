# Enterprise DevOps CI/CD Project

## Project Overview

This project demonstrates an end-to-end CI/CD pipeline for deploying a containerized web application using GitHub, Jenkins, Docker, NGINX, and AWS EC2.

## Architecture

GitHub → Jenkins → Docker Image → Docker Container → NGINX → AWS EC2

## Technologies Used

- AWS EC2
- Jenkins
- GitHub
- Docker
- NGINX
- Linux
- Terraform

## Project Workflow

1. Application source code is stored in GitHub.
2. Jenkins pulls the latest code from the GitHub repository.
3. Jenkins builds a Docker image using the Dockerfile.
4. Jenkins stops and removes the old Docker container.
5. Jenkins deploys a new Docker container.
6. NGINX serves the web application.
7. The application is accessed through the AWS EC2 server.

## CI/CD Pipeline

```text
Developer
    ↓
GitHub Repository
    ↓
Jenkins Pipeline
    ↓
Docker Image Build
    ↓
Docker Container Deployment
    ↓
NGINX Web Application
    ↓
AWS EC2

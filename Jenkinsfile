pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve -input=false'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t enterprise-devops:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker stop enterprise-devops-container || true'
                sh 'docker rm enterprise-devops-container || true'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name enterprise-devops-container -p 8081:80 enterprise-devops:latest'
            }
        }
    }
}
stage('Test App Server SSH') {
    steps {
        sshagent(['app-server-ssh']) {
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@10.0.1.161 "hostname && docker --version"
            '''
        }
    }
}
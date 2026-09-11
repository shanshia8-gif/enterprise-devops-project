pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
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

        stage('Test Application') {
            steps {
                sh 'curl -f http://localhost:8081'
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
    }

    post {
        always {
            deleteDir()
        }
    }
}
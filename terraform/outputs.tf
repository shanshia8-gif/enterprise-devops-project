output "jenkins_public_ip" {
  description = "Public IP address of the Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8081"
}

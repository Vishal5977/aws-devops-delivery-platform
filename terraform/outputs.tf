output "public_ip" {
  description = "Public IP used by Ansible and Jenkins access."
  value       = aws_instance.platform.public_ip
}

output "jenkins_url" {
  description = "Jenkins URL after Ansible configuration completes."
  value       = "http://${aws_instance.platform.public_ip}:8080"
}

output "ecr_repository_url" {
  description = "Private image repository used by Jenkins."
  value       = aws_ecr_repository.application.repository_url
}

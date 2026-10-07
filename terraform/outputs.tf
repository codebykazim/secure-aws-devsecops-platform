output "jenkins_master_public_ip" {
  description = "Public IP of the Jenkins Master / Ansible Controller"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_agent_public_ip" {
  description = "Public IP of the Jenkins Agent"
  value       = aws_instance.jenkins_agent.public_ip
}

output "jenkins_master_private_ip" {
  description = "Private IP of the Jenkins Master"
  value       = aws_instance.jenkins_master.private_ip
}

output "jenkins_agent_private_ip" {
  description = "Private IP of the Jenkins Agent"
  value       = aws_instance.jenkins_agent.private_ip
}

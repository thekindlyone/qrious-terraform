output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.server.public_ip
}
output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.server.public_dns
}
output "ssh_command" {
  description = "ssh command to log into ec2"
  value       = "ssh -o 'IdentitiesOnly yes' -i 'ec2_ssh_key.pem' ec2-user@${aws_instance.server.public_dns}"
}

output "api_url" {
  description = "api url"
  value       = "http://${aws_instance.server.public_ip}/api"
}


output "root_url" {
  description = "api url"
  value       = "http://${aws_instance.server.public_ip}"
}

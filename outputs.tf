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


output "curl" {
  description = "curl command example"
  value       = <<EOT
curl --header "Content-Type: application/json" \
  --request GET \
  --data '{"start":1628946332,"end":1628946656}' \
  http://${aws_instance.server.public_ip}/api/metrics/period
EOT
}


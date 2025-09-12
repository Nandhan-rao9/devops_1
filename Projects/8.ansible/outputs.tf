output "public_ip" {
  value = aws_instance.vm.public_ip
}

output "ssh_command" {
  value = "ssh -i ./.ssh/${var.project_name}.pem ec2-user@${aws_instance.vm.public_ip}"
}

output "key_path" {
  value = "${path.module}/.ssh/${var.project_name}.pem"
}


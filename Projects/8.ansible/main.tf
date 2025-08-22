# Grab the default VPC to attach the security group
data "aws_vpc" "default" {
  default = true
}

# Latest Amazon Linux 2023 AMI via SSM parameter (safer than hardcoding AMI IDs)
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Generate an SSH private key locally
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload the public key to AWS as an EC2 Key Pair
resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Save the private key to a local file (chmod 600)
resource "local_file" "private_key_pem" {
  filename        = "${path.module}/.ssh/${var.project_name}.pem"
  content         = tls_private_key.ssh.private_key_pem
  file_permission = "0600"
}

# Security group allowing SSH (22) from your IP only (or 0.0.0.0/0 for quick demo)
resource "aws_security_group" "ssh_only" {
  name   = "${var.project_name}-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description      = "All egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = { Name = "${var.project_name}-sg" }
}

# EC2 instance
resource "aws_instance" "vm" {
  ami                         = data.aws_ssm_parameter.al2023_ami.value
  instance_type               = "t2.micro" # free-tier eligible in most regions
  key_name                    = aws_key_pair.this.key_name
  vpc_security_group_ids      = [aws_security_group.ssh_only.id]
  associate_public_ip_address = true

  # Optional: tiny bootstrap (safe no-op)
  user_data = <<-EOF
  #!/bin/bash
  echo "Provisioned by Terraform on $(date)" > /etc/motd
  EOF

  tags = { Name = "${var.project_name}-ec2" }
}

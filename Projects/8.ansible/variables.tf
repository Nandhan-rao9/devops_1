variable "project_name" {
  type    = string
  default = "tf-ec2-demo"
}

variable "aws_region" {
  type    = string
  default = "ap-south-1" # change if you use another region
}

# Replace with YOUR public IP + /32 to lock down SSH
variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR (e.g., 1.2.3.4/32)"
  default     = "0.0.0.0/0" # open to world (ok for a quick demo). Prefer X.Y.Z.W/32.
}

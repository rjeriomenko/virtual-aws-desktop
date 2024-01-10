variable "role_arn" {
  type = string
  sensitive = true
}
variable "AWS_ACCESS_KEY_ID" {
  type = string
  sensitive = true
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  sensitive = true
}

output "instance_ssh_address" {
  value = "ubuntu@ec2-${replace(aws_instance.example.public_ip, ".", "-")}.compute-1.amazonaws.com"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  assume_role {
    role_arn = var.role_arn
  }
}

resource "aws_instance" "charles-ready" {
  ami = "ami-01449267037290a88"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  tags = {
    Name = "charles-ready"
  }
  vpc_security_group_ids = [aws_security_group.ingress-egress-all-test.id]
}

resource "aws_key_pair" "ssh-key" {
  key_name = "aws-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
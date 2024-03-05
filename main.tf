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

# output "instance_ssh_address" {
#   value = "ubuntu@ec2-${replace(aws_instance.projects-ready.public_ip, ".", "-")}.compute-1.amazonaws.com"
# }

output "second_debug_address" {
  value = "ubuntu@ec2-${replace(aws_instance.java-ready.public_ip, ".", "-")}.compute-1.amazonaws.com"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  assume_role {
    role_arn = var.role_arn
  }
}

# resource "aws_instance" "projects-ready" {
#   ami = "ami-023aee11add72edef"
#   instance_type = "t2.medium"
#   key_name = aws_key_pair.ssh-key.key_name
#   tags = {
#     Name = "projects-ready"
#   }
#   vpc_security_group_ids = [aws_security_group.ingress-egress-all-test.id]
# }

resource "aws_instance" "java-ready" {
  ami = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.medium"
  key_name = aws_key_pair.ssh-key.key_name
  tags = {
    Name = "java-ready"
  }
  vpc_security_group_ids = [aws_security_group.ingress-egress-all-test.id]
}

resource "aws_key_pair" "ssh-key" {
  key_name = "aws-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
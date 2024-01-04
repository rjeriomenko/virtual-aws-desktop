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

output "instance_ip_address" {
  value = aws_instance.example.public_ip
}

provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  assume_role {
    role_arn = var.role_arn
  }
}

resource "aws_instance" "example" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  tags = {
    Name = "terraform-example"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "aws-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
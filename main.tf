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
  tags = {
    Name = "terraform-example"
  }
}
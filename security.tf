resource "aws_security_group" "ingress-all-test" {
  name = "allow-all-sg"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
}
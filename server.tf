# creating instance 1

resource "aws_instance" "exam-server" {
  ami             = "ami-0aaa5410833273cfe"
  instance_type   = "t2.micro"
  key_name        = "root-key"
  security_groups = [aws_security_group.exam-security-grp-rule.id]
  subnet_id       = aws_subnet.exam-public-subnet1.id
  availability_zone = "eu-west-2a"
  user_data = file("jen-server.sh")
  tags = {
    Name   = "exam-server-1"
    source = "terraform"
  }
}

# creating instance 1

resource "aws_instance" "exam-server" {
  ami             = "ami-0557a15b87f6559cf"
  instance_type   = "t2.micro"
  key_name        = "root-server2-london"
  security_groups = [aws_security_group.exam-security-grp-rule.id]
  subnet_id       = aws_subnet.exam-public-subnet1
  availability_zone = "eu-west-2a"
  tags = {
    Name   = "exam-server-1"
    source = "terraform"
  }
}
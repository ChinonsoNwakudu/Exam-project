data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "jenkins-server" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = "root-key"
  subnet_id                   = aws_subnet.exam-public-subnet1.id
  vpc_security_group_ids      = [aws_security_group.exam-security-grp-rule.id]
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("jen-server.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

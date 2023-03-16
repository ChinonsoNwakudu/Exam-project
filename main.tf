provider "aws" {
  region = "eu-west-2"
}


# Create VPC
resource "aws_vpc" "exam_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "exam_vpc"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "exam_internet_gateway" {
  vpc_id = aws_vpc.exam_vpc.id
  tags = {
    Name = "exam_internet_gateway"
  }
}

#create public Route Table

resource "aws_route_table" "exam-route-table-public" {
  vpc_id = aws_vpc.exam_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.exam_internet_gateway.id
  }
  tags = {
    Name = "exam-route-table-public"
  }
}

# Associate public subnet 1 with public route table

resource "aws_route_table_association" "exam-public-subnet1-association" {
  subnet_id      = aws_subnet.exam-public-subnet1.id
  route_table_id = aws_route_table.exam-route-table-public.id
}
# Associate public subnet 2 with public route table
resource "aws_route_table_association" "exam-public-subnet2-association" {
  subnet_id      = aws_subnet.exam-public-subnet2.id
  route_table_id = aws_route_table.exam-route-table-public.id
}

# Create Public Subnet-1

resource "aws_subnet" "exam-public-subnet1" {
  vpc_id                  = aws_vpc.exam_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "exam-public-subnet1"
  }
}
# Create Public Subnet-2
resource "aws_subnet" "exam-public-subnet2" {
  vpc_id                  = aws_vpc.exam_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"
  tags = {
    Name = "exam-public-subnet2"
  }
}

resource "aws_network_acl" "exam-network_acl" {
  vpc_id     = aws_vpc.exam_vpc.id
  subnet_ids = [aws_subnet.exam-public-subnet1.id, aws_subnet.exam-public-subnet2.id]

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

# Create Security Group to allow port 22, 80 and 443

resource "aws_security_group" "exam-security-grp-rule" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH, HTTP and HTTPS inbound traffic for private instances"
  vpc_id      = aws_vpc.exam_vpc.id
 ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.exam-load_balancer_sg.id]
  }
 ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.exam-load_balancer_sg.id]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   
  }
  tags = {
    Name = "exam-security-grp-rule"
  }
}
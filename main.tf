provider "aws" {
  region = "us-east-1"
}

variable "cidr_value" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr_value
}

resource "aws_subnet" "sb1" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.my-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig1.id
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id = aws_subnet.sb1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "sg1-my" {
  name = "my-secrity-grup"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    description = "allow 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow-from out"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2-my" {
  ami = "ami-0ecb62995f68bb549"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sb1.id
  vpc_security_group_ids = [aws_security_group.sg1-my.id]
}


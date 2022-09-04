resource "aws_vpc" "vpc-terraform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "vpc-public" {
  vpc_id     = aws_vpc.vpc-terraform.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-vpc-public"
  }
}

resource "aws_subnet" "vpc-private" {
  vpc_id     = aws_vpc.vpc-terraform.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "terraform-vpc-private"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.vpc-terraform.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_eip" "terraform-nat-ip" {
  vpc = true
  tags = {
    Name = "terraform-nat-ip"
  }
}

resource "aws_nat_gateway" "terraform-nat" {
  allocation_id = aws_eip.terraform-nat-ip.id
  subnet_id     = aws_subnet.vpc-public.id

  tags = {
    Name = "terraform-gw-nat"
  }
}

resource "aws_route_table" "terraform-rt-public" {
  vpc_id = aws_vpc.vpc-terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = "terraform-route-public"
  }
}

resource "aws_route_table_association" "association-public-private" {
  subnet_id      = aws_subnet.vpc-public.id
  route_table_id = aws_route_table.terraform-rt-public.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc-terraform.id

  ingress {
    description = "SSH from VPC"
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
    Name = "allow_ssh"
  }
}
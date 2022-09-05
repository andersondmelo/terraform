resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet-public"
  }
}

resource "aws_network_interface" "ec2-network" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "terraform-rt-public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = "terraform-route-public"
  }
}

resource "aws_route_table_association" "association-public-private" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.terraform-rt-public.id
}
output "igw-id" {
  value = aws_internet_gateway.terraform-igw
}

output "vpc-public-id" {
  value = aws_subnet.vpc-public.id
}

output "aws_security_group" {
  value = aws_security_group.allow_ssh.id
}
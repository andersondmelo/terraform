resource "aws_instance" "ec2" {
  ami                         = var.ec2
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2-key.key_name
  subnet_id                   = aws_subnet.my_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]

  tags = {
    Name = "vm-terraform"
  }
}
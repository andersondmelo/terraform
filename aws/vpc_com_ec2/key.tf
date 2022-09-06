resource "aws_key_pair" "ec2-key" {
  public_key = file("./keys/key.pub")
}
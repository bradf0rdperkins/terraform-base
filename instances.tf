resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.fcc_acedirect_prod_public_1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.fcc-acedirect-prod-web-sg.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

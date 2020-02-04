resource "aws_security_group" "fcc-acedirect-prod-web-sg" {
  name = "fcc-acedirect-prod-web-sg"
  description = "Allow web server traffic"
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id
  
  #Ingress
  dynamic "ingress" {
    for_each = [22, 443, 8080, 80, 8443, 5060, 3478, 5038, 8005, 3306, 8081]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  dynamic "ingress" {
    for_each = [3478, 5061, 3306, 5060]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
      from_port   = 10000
      to_port     = 20000
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 10000
      to_port     = 20000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
  #Egress
  dynamic "egress" {
    for_each = [80, 8443, 443, 3478, 5038, 3306]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  dynamic "egress" {
    for_each = [3478, 443, 50561, 3306]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
      from_port   = 10000
      to_port     = 20000
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 10000
      to_port     = 20000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 7000
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 7000
      to_port     = 65535
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

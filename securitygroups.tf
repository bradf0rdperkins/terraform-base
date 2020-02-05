resource "aws_security_group" "fcc-acedirect-prod-web-sg" {
  name = "fcc-acedirect-prod-web-sg"
  description = "Allow web server traffic"
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id
  tags = {
    Name = "fcc-acedirect-prod-web-sg"
  }

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

  ingress {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["156.154.0.0/16"]
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

  egress {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["156.154.0.0/16"]
  }

  egress {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      security_groups = [aws_security_group.fcc-acedirect-prod-rds-sg.id]
  }
}

resource "aws_security_group" "fcc-acedirect-prod-providers-sg" {
  name = "fcc-acedirect-prod-providers-sg"
  description = "Allow traffic from specific phone providers in"
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id
  tags = {
    Name = "fcc-acedirect-prod-providers-sg"
  }

  #Ingress
  dynamic "ingress" {
    for_each = ["71.178.44.250/32", "174.137.37.0/24", "74.119.0.0/16", "208.94.16.0/24", "208.95.32.0/24", "73.14.137.136/32", "13.56.121.236/32", "54.176.251.137/32", "13.52.11.155/32", "13.52.109.48/32", "52.8.246.26/32", "13.57.81.12/32", "52.53.117.180/32", "156.154.0.0/16", "162.253.0.0/24", "209.169.0.0/16", "24.73.117.0/24", "35.169.254.158/32", "54.237.194.197/32", "66.220.26.222/32", "70.33.169.8/32", "71.119.0.0/16", "8.34.145.6/32", "8.39.223.0/24", "75.71.247.71/32", "10.1.3.0/24", "64.106.221.178/32", "76.25.49.108/32", "76.120.87.61/32"]
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [ingress.value]
    }
  }

  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "ESP (50)"
      cidr_blocks = ["209.18.122.132/32"]
      description = "iConectiv"
  }

  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "AH (51)"
      cidr_blocks = ["209.18.122.132/32"]
      description = "iConectiv"
  }

  ingress {
      from_port   = 500
      to_port     = 500
      protocol    = "udp"
      cidr_blocks = ["209.18.122.132/32"]
      description = "iConectiv"
  }

  ingress {
      from_port   = 4500
      to_port     = 4500
      protocol    = "udp"
      cidr_blocks = ["209.18.122.132/32"]
      description = "iConectiv"
  }

  #Egress
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "fcc-acedirect-prod-rds-sg" {
  name = "fcc-acedirect-prod-rds-sg"
  description = "Allow RDS server traffic"
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id
  tags = {
    Name = "fcc-acedirect-prod-rds-sg"
  }

  #Egress
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
}

resource "aws_security_group_rule" "fcc-acedirect-prod-rds-sg_extra_tcp_rule" {
    security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    type = "ingress"
    source_security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "fcc-acedirect-prod-rds-sg_extra_udp_rule" {
    security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    type = "ingress"
    source_security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
  }
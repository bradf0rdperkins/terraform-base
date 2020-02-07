resource "aws_security_group" "fcc-acedirect-prod-web-sg" {
  name = "fcc-acedirect-prod-web-sg"
  description = "Allow web server traffic"
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id
  tags = {
    Name = "fcc-acedirect-prod-web-sg"
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
      protocol    = "50"
      cidr_blocks = ["209.18.122.132/32"]
      description = "iConectiv"
  }

  ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "51"
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
}

variable "ingress_web_ports_1" {
  default = [22, 443, 8080, 80, 8443, 5060, 3478, 5038, 8005, 3306, 8081]
}
variable "ingress_web_ports_2" {
  default = [3478, 5061, 3306, 5060]
}
variable "egress_web_ports_1" {
  default = [80, 8443, 443, 3478, 5038, 3306]
}
variable "egress_web_ports_2" {
  default = [3478, 443, 50561, 3306]
}
variable "protocols" {
  default = ["tcp", "udp"]
}

resource "aws_security_group_rule" "ingress_web_1" {
  count = "${length(var.ingress_web_ports_1)}"

  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "${element(var.ingress_web_ports_1, count.index)}"
  to_port     = "${element(var.ingress_web_ports_1, count.index)}"

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "ingress_web_2" {
  count = "${length(var.ingress_web_ports_2)}"

  type        = "ingress"
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "${element(var.ingress_web_ports_2, count.index)}"
  to_port     = "${element(var.ingress_web_ports_2, count.index)}"

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "ingress_web_3" {
  count = "${length(var.protocols)}"

  type        = "ingress"
  protocol    = "${element(var.protocols, count.index)}"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 10000
  to_port     = 20000

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "ingress_web_4" {
  type        = "ingress"
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = -1
  to_port     = -1

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "ingress_web_5" {
  type        = "ingress"
  protocol    = "-1"
  cidr_blocks = ["156.154.0.0/16"]
  from_port   = 0
  to_port     = 0

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_1" {
  count = "${length(var.egress_web_ports_1)}"

  type        = "egress"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "${element(var.egress_web_ports_1, count.index)}"
  to_port     = "${element(var.egress_web_ports_1, count.index)}"

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_2" {
  count = "${length(var.egress_web_ports_2)}"

  type        = "egress"
  protocol    = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "${element(var.egress_web_ports_2, count.index)}"
  to_port     = "${element(var.egress_web_ports_2, count.index)}"

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_3" {
  count = "${length(var.protocols)}"

  type        = "egress"
  protocol    = "${element(var.protocols, count.index)}"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 10000
  to_port     = 20000

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_4" {
  count = "${length(var.protocols)}"

  type        = "egress"
  protocol    = "${element(var.protocols, count.index)}"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 7000
  to_port     = 65535

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_4" {
  type        = "egress"
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = -1
  to_port     = -1

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "egress_web_5" {
  type        = "egress"
  protocol    = "-1"
  cidr_blocks = ["156.154.0.0/16"]
  from_port   = 0
  to_port     = 0

  security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
}

resource "aws_security_group_rule" "igress_rds_1" {
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = ["73.14.137.136/32"]
  from_port   = 3306
  to_port     = 3306

  security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
}

resource "aws_security_group_rule" "egress_rds_1" {
  type        = "ingress"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 0
  to_port     = 0

  security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
}

resource "aws_security_group_rule" "fcc-acedirect-prod-rds-sg_extra_tcp_rule" {
    security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
    from_port                = 0
    to_port                  = 65535
    protocol                 = "tcp"
    type                     = "ingress"
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

resource "aws_security_group_rule" "fcc-acedirect-prod-web-sg_extra_rule" {
    security_group_id = "${aws_security_group.fcc-acedirect-prod-web-sg.id}"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    type = "egress"
    source_security_group_id = "${aws_security_group.fcc-acedirect-prod-rds-sg.id}"
}
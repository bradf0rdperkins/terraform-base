# Internet VPC
resource "aws_vpc" "fcc_acedirect_prod_vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "fcc-acedirect-prod-vpc"
  }
}

# Subnets
resource "aws_subnet" "fcc_acedirect_prod_db_west_2b" {
  vpc_id                  = aws_vpc.fcc_acedirect_prod_vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2b"

  tags = {
    Name = "fcc-acedirect-prod-db-west-1b"
  }
}

resource "aws_subnet" "fcc_acedirect_prod_db_west_2a" {
  vpc_id                  = aws_vpc.fcc_acedirect_prod_vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "fcc-acedirect-prod-db-west-2a"
  }
}

resource "aws_subnet" "fcc_acedirect_prod_public_1" {
  vpc_id                  = aws_vpc.fcc_acedirect_prod_vpc.id
  cidr_block              = "10.1.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "fcc-acedirect-prod-public-1"
  }
}

#DB Subnet Group
resource "aws_db_subnet_group" "fcc-acedirect-db-subnet-group" {
  name       = "fcc-acedirect-db-subnet-group"
  subnet_ids = ["${aws_subnet.fcc_acedirect_prod_db_west_2a.id}", "${aws_subnet.fcc_acedirect_prod_db_west_2b.id}"]

  tags = {
    Name = "mysql DB subnet group"
  }
}


# Internet GW
resource "aws_internet_gateway" "fcc_acedirect_prod_igw" {
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id

  tags = {
    Name = "fcc-acedirect-prod-igw"
  }
}

# route tables
resource "aws_route_table" "fcc-acedirect-prod-public-rt" {
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fcc_acedirect_prod_igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.fcc_acedirect_prod_igw.id
  }

  tags = {
    Name = "fcc-acedirect-prod-public-rt"
  }
}

# route associations public
resource "aws_route_table_association" "fcc_acedirect_prod_db_west_2a" {
  subnet_id      = aws_subnet.fcc_acedirect_prod_db_west_2a.id
  route_table_id = aws_route_table.fcc-acedirect-prod-public-rt.id
}

resource "aws_route_table_association" "fcc_acedirect_prod_db_west_2b" {
  subnet_id      = aws_subnet.fcc_acedirect_prod_db_west_2b.id
  route_table_id = aws_route_table.fcc-acedirect-prod-public-rt.id
}

resource "aws_route_table_association" "fcc_acedirect_prod_public_1" {
  subnet_id      = aws_subnet.fcc_acedirect_prod_public_1.id
  route_table_id = aws_route_table.fcc-acedirect-prod-public-rt.id
}

#Elastic IPs
resource "aws_eip" "fcc-openam-eip" {
  instance = "${aws_instance.example.id}"
  vpc      = true
}

/*
resource "aws_eip" "fcc-node-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "fcc-dvpn-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "fcc-sswan-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "fcc-asterisk-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "fcc-stun-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "fcc-proxy-eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}
*/
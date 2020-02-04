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

# Internet GW
resource "aws_internet_gateway" "fcc_acedirect_prod_igw" {
  vpc_id = aws_vpc.fcc_acedirect_prod_vpc.id

  tags = {
    Name = "fcc-acedirect-prod-igw"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = aws_subnet.main-public-3.id
  route_table_id = aws_route_table.main-public.id
}


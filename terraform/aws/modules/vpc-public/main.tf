locals {
  tags = {
    environment = var.environment,
    location    = var.location
    layer       = var.layer
    module      = "vpc-public"
  }
}
resource "aws_vpc" "vpc_main" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"
  tags       = merge(local.tags, { Name = "vpc-main" })
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id
}

resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = cidrsubnet(aws_vpc.vpc_main.cidr_block, 4, 1)
  tags       = merge(local.tags, { Name = "public-subnet-0" })

}

resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = cidrsubnet(aws_vpc.vpc_main.cidr_block, 4, 2)
  tags       = merge(local.tags, { Name = "private-subnet-0" })
}

# Route table for Public Subnet's
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Route table for Private Subnet's
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

# Route table Association with Public Subnet's
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = aws_route_table.public_rt.id
}

# Route table Association with Private Subnet's
resource "aws_route_table_association" "private_subnet_rt_association" {
  subnet_id      = aws_subnet.private_subnets.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

resource "aws_eip" "nate_ip" {
  vpc = true
}

# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nate_ip.id
  subnet_id     = aws_subnet.public_subnets.id
}

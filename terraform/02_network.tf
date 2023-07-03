##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC 
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Public subnets 
resource "aws_subnet" "public-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_1_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "public-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_2_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
}

# Private subnets 
resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_1_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_2_cidr_block
  availability_zone = data.aws_availability_zones.available.names[1]
}

# Route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# Route table associations
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private.id
}


# Elastic IP 
resource "aws_eip" "elastic-ip-for-nat-gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.gw]
}

# NAT Gateway 
resource "aws_nat_gateway" "public1" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-1.id
  depends_on    = [aws_eip.elastic-ip-for-nat-gw]
}
resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.public1.id
  destination_cidr_block = "0.0.0.0/0"
}


# Internet gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Route public traffic through the Internet gateway 
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Key pairs 
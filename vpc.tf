resource "aws_vpc" "CRM_vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "CRM_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.CRM_vpc.id

  tags = {
    Name = "CRM_gw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.CRM_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "CRM_public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.CRM_vpc.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "CRM_private_subnet"
  }
}

resource "aws_route_table" "CRM_public_rt"{
  vpc_id = aws_vpc.CRM_vpc.id

  # route {
  #   cidr_block = "10.0.0.0/16"
  #   gateway_id = aws_internet_gateway.gw.id
  # }
  tags = {
    Name = "CRM_public_rt"
  }
}

resource "aws_route_table" "CRM_private_rt"{
  vpc_id = aws_vpc.CRM_vpc.id

  tags = {
    Name = "CRM_private_rt"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.CRM_private_rt.id
}

resource "aws_route_table_association" "public_a_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.CRM_public_rt.id
}

# resource "aws_route_table_association" "public_a_gw" {
#   gateway_id     = aws_internet_gateway.gw.id
#   route_table_id = aws_route_table.CRM_public_rt.id
# }

resource "aws_route" "r_gw" {
  route_table_id            = aws_route_table.CRM_public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.gw.id
}
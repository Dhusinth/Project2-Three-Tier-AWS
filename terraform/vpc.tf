resource "aws_vpc" "three-tier-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "three-tier-vpc"
  }
}

resource "aws_internet_gateway" "three-tier-internet-gateway" {
  vpc_id = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-internet-gateway"
  }
}

resource "aws_route_table" "three-tier-public-route-table" {
  vpc_id = aws_vpc.three-tier-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three-tier-internet-gateway.id
  }

  tags = {
    Name = "three-tier-route-table"
  }
}

resource "aws_subnet" "three-tier-web-public-subnet-1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "three-tier-web-public-subnet-1"
  }
}

resource "aws_route_table_association" "three-tier-public-route-table-association-1" {
  subnet_id      = aws_subnet.three-tier-web-public-subnet-1.id
  route_table_id = aws_route_table.three-tier-public-route-table.id
}

resource "aws_subnet" "three-tier-app-private-subnet-1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "three-tier-app-private-subnet-1"
  }
}

resource "aws_nat_gateway" "three-tier-nat-gateway" {
  allocation_id = aws_eip.three-tier-eip.id
  subnet_id     = aws_subnet.three-tier-web-public-subnet-1.id

  tags = {
    Name = "three-tier-nat-gateway"
  }


  depends_on = [aws_internet_gateway.three-tier-internet-gateway]
}

resource "aws_route_table" "three-tier-private-route-table" {
  vpc_id = aws_vpc.three-tier-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.three-tier-nat-gateway.id
  }

  tags = {
    Name = "three-tier-private-route-table"
  }
}

resource "aws_route_table_association" "three-tier-privat-route-table-association-1" {
  subnet_id      = aws_subnet.three-tier-app-private-subnet-1.id
  route_table_id = aws_route_table.three-tier-private-route-table.id
}


resource "aws_subnet" "three-tier-db-private-subnet-1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "three-tier-db-private-subnet-1"
  }
}

resource "aws_subnet" "three-tier-db-private-subnet-2" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "three-tier-db-private-subnet-2"
  }
}


resource "aws_eip" "three-tier-eip" {
  domain = "vpc"
  tags = {
    Name = "three-tier-nat-eip"
  }
}


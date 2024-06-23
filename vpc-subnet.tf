

 # CREATE VPC

resource "aws_vpc" "vpc-1" {
  cidr_block = var.vpc-cidr-block
  #instance_tenancy = "default"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc-name
  }
}



# CREATE PUBLIC SUBNETS
resource "aws_subnet" "Public-Subnet-1" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.publicsubnet-1-cidr
  availability_zone = "us-east-1a"


  tags = {
    Name = "PUBSUB-1"
  }
}



resource "aws_subnet" "Public-Subnet-2" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.publicsubnet-2-cidr
  availability_zone = "us-east-1b"


  tags = {
    Name = "PUBSUB-2"
  }
}


# CREATE PRIVATE SUBNETS

resource "aws_subnet" "Private-Subnet-1" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.privatesubnet-1-cidr
  availability_zone = "us-east-1c"


  tags = {
    Name = "PRIVATESUB-1"
  }
}

resource "aws_subnet" "Private-Subnet-2" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.privatesubnet-2-cidr
  availability_zone = "us-east-1d"


  tags = {
    Name = "PRIVATEBSUB-2"
  }
}



# PUBLIC ROUTE TABLE
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc-1.id


  tags = {
    Name = "Public-Route-Table"
  }
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-1.id


  tags = {
    Name = "Private-Route-Table"
  }
}



# PUBLIC SUBNET ASSOCIATION
resource "aws_route_table_association" "Public-sub-assoc-1" {
  subnet_id      = aws_subnet.Public-Subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}


resource "aws_route_table_association" "Public-sub-assoc-2" {
  subnet_id      = aws_subnet.Public-Subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}


# PRIVATE SUBNET ASSOCIATION
resource "aws_route_table_association" "Private-sub-assoc-1" {
  subnet_id      = aws_subnet.Private-Subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}


resource "aws_route_table_association" "Private-sub-assoc-2" {
  subnet_id      = aws_subnet.Private-Subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}



# CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "vpc-IGW" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "VPC-IGW"
  }
}



resource "aws_route" "internet-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-IGW.id
}



resource "aws_subnet" "Private-Subnet-3" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.privatesubnet-3-cidr
  availability_zone = "us-east-1e"


  tags = {
    Name = "PRIVATESUB-3"
  }
}


resource "aws_subnet" "Private-Subnet-4" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = var.privatesubnet-4-cidr
  availability_zone = "us-east-1f"


  tags = {
    Name = "PRIVATESUB-4"
  }
}

/*
resource "aws_route" "natgateway-route" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.vpc-natgateway-1.id
}
*/




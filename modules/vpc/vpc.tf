
### VPC ###
resource "aws_vpc" "dev_vpc" {
    cidr_block           = var.cidr_block["vpc_cidr"]
    instance_tenancy     = var.vpc_tenancy
    enable_dns_support   = var.vpc_dns_support
    enable_dns_hostnames = var.vpc_dns_hostnames
    

    tags = {
        Name = var.vpc_name
    }
}


### Public Subnet ###
resource "aws_subnet" "publicsubnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
 cidr_block              = var.cidr_block["public_subnet"]
  //count  = local.public_count

  //cidr_block = element(var.public_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip
  tags = {
    Name = var.public_subnet
  }
}
### Private Subnet ###
resource "aws_subnet" "privatesubnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.cidr_block["private_subnet"]
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnet
  }
}

#### IGW ###
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "igw"
  }
}
### Route Table ###
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.cidr_block["route_subnet"]
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_route"
  }
}
### Public Subnet Assc in Route Table  ###
resource "aws_route_table_association" "route-asst" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.route_table.id
}
### NAT EIP ###
resource "aws_eip" "nateip" {
  vpc = true
}

### NAT GATEWAY ####
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.publicsubnet.id

  tags = {
    Name = "ngw"
  }
}
### Private Route Table ###
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = var.cidr_block["route_subnet"]
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Private_route"
  }
}
### associate private subnet with NAT route table  ###
resource "aws_route_table_association" "private-asst" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.private_route.id
}


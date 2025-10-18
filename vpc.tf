resource "aws_vpc" "main" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"          = "1"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"          = "1"
    }
}

resource "aws_subnet" "subnet3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.32.0/20"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true
    tags = {
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/internal-elb"          = "1"
    }

}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet3_association" {
  subnet_id = aws_subnet.subnet3.id
  route_table_id = aws_route_table.route_table.id
}
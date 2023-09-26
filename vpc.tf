resource "aws_vpc" "terra_vpc"{
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "terra-vpc"
    }
}


resource "aws_internet_gateway" "efs-ig"{
    vpc_id = aws_vpc.terra_vpc.id
    tags = {
        Name =  "EFS-IG"
    }
}

resource "aws_subnet" "subnetpub"{
    vpc_id = aws_vpc.terra_vpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "subnet-pub"
    }
}

resource "aws_subnet" "subnetpriv"{
    vpc_id = aws_vpc.terra_vpc.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"

    tags = {
        Name = "subnet-priv"
    }
}

resource "aws_route_table" "efs_rt" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.efs-ig.id
  }
  tags = {
    Name = "EFS-RT"
  }
}

resource "aws_route_table_association" "efs_rt_association" {
  subnet_id      = aws_subnet.subnetpub.id
  route_table_id = aws_route_table.efs_rt.id
}




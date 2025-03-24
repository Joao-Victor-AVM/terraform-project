resource "aws_vpc" "vpc_jrlb_jvavm"{
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.1.0/24"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.2.0/24"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.3.0/24"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

/*
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_jrlb_jvavm.id

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_jrlb_jvavm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = "rtb-051032fe8e928a9ad"
}

output "subnetid" {
  value = aws_subnet.public_subnet.id
}*/
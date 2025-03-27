
resource "aws_vpc" "vpc_jrlb_jvavm"{
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.1.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc_jrlb_jvavm.id
  cidr_block = "172.31.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

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


resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.route_table.id
}

output "vpc_id" {
  value = aws_vpc.vpc_jrlb_jvavm.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}


output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

/*
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "private_subnet1_id" {}
variable "private_subnet2_id" {}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group para servidor web"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_security_group" "private_web_sg" {
  name        = "web_sg"
  description = "Security group para servidor web"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group para RDS, permitindo acesso da instancia EC2 privada"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_web_sg.id]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_security_group" "sg_alb" {
  name        = "jrlb_jvavm_alb"
  vpc_id      = var.vpc_id
  description = "Security Group for ALB"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami             = "ami-08b5b3a93ed654d19"  # Amazon Linux 2
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id       = var.public_subnet_id
  associate_public_ip_address = true 

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_instance" "private_server" {
  ami             = "ami-08b5b3a93ed654d19"  # Amazon Linux 2
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private_web_sg.id]
  subnet_id       = var.private_subnet1_id
  associate_public_ip_address = true 

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_instance" "private_server2" {
  ami             = "ami-08b5b3a93ed654d19"  # Amazon Linux 2
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private_web_sg.id]
  subnet_id       = var.private_subnet2_id
  associate_public_ip_address = true 

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [private_subnet1_id]

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_db_instance" "jrlb_jvavm_RDS" {
  identifier            = "jrlb-jvavm-rds"
  instance_class        = "db.t3.micro"
  engine               = "mysql"
  engine_version       = "8.0"
  username             = "jv"
  password             = "password123"
  allocated_storage    = 20
  port                 = 3306
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  backup_retention_period = 7

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}*/
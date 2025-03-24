variable "vpc_id" {}
variable "subnet_id" {}

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

resource "aws_instance" "web_server" {
  ami             = "ami-08b5b3a93ed654d19"  # Amazon Linux 2
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id       = var.subnet_id
  associate_public_ip_address = true 

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
    cidr_blocks = [aws_security_group.web_sg.id]
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

resource "aws_instance" "private_server" {
  ami             = "ami-08b5b3a93ed654d19"  # Amazon Linux 2
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.private_web_sg.id]
  subnet_id       = var.subnet_id
  associate_public_ip_address = true 

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

/*
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group para RDS, permitindo acesso da instancia EC2"
  vpc_id      = "vpc-05c5b4cc3ecc3b273"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
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

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = ["subnet-09348fbdb9933d2a5", "subnet-01bbc5886d21d6a18"] 

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
  vpc_security_group_ids = ["sg-097e10349089806e7"]
  skip_final_snapshot  = true
  publicly_accessible  = false
  backup_retention_period = 7

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}
*/
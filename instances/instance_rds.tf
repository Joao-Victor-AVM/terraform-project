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
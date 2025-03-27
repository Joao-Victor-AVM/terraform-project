
variable "vpc_id" {}

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
  name        = "private_web_sg"
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
  name        = "sg_alb"
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

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

output "web_sg"{
  value = aws_security_group.web_sg.id
}

output "private_web_sg"{
  value = aws_security_group.private_web_sg.id
}

output "rds_sg"{
  value = aws_security_group.rds_sg.id
}

output "sg_alb_name"{
  value = aws_security_group.sg_alb.name
}

output "sg_alb_id"{
  value = aws_security_group.sg_alb.id
}
/*
variable "vpc_id" {}
variable "public_subnet1_id" {}
variable "public_subnet2_id" {}
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

resource "aws_security_group" "jrlb_jvavm_sg_alb" {
  name        = "jrlb_jvavm_sg_alb"
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

resource "aws_launch_configuration" "jrlb_jvavm_wevserver_lauch_config"{
  name_prefix = "jrlb_jvavm_wevserver_lauch_config"
  image_id = ami-0d0f28110d16ee7d6
  instance_type = "t3.micro"
  key_name = "Codepoint"
  security_groups = [aws_security_group.jrlb_jvavm_sg_alb.name]

  user_data = #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo “Hello World from $(hostname -f)” > /var/www/html/index.html
}

resource "aws_lb_target_group" "jrlb_jvavm_target_group"{
  name = "jrlb_jvavm_target_group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_autoscalling_group" "jrlb_jvavm_asg"{
 name = "jrlb_jvavm_asg"
 desired_capacity = 2
 max_size = 4
 min_size = 1
 target_group_arns = [{aws_lb_target_group.jrlb_jvavm_target_group}]
 health_check_type = "EC2"
 launch_configuration = aws_lauch_configuration.web_server_launch_config.name
 vpc_zone_identifier = [{var.public_subnet1_id}, {var.public_subnet1_id}]
 
 tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  } 
}

resource "aws_lb" "jrlb_jvavm_lb" {
  name = "jrlb_jvavm_lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.jrlb_jvavm_sg_alb.id]
  subnets = [var.public_subnet1_id, var.public_subnet2_id]

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  } 
}

resource "aws_lb_listener" "jrlb_jvavm_front_end"{
  load_balancer_arn = aws_lb.jrlb_jvavm_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action{
    type = "forward"
    target_group_arns = aws_lb_target_group.jrlb_jvavm_target_group.arn
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [var.private_subnet1_id]

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
  publicly_accessible = no
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
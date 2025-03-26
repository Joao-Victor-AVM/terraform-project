/*
variable "vpc_id" {}
variable "public_subnet1_id" {}
variable "public_subnet2_id" {}
variable "private_subnet1_id" {}
variable "private_subnet2_id" {}
variable "web_sg_id" {}
variable "private_web_sg_id" {}
variable "sg_alb_name" {}
variable "sg_alb_id" {}


resource "aws_launch_configuration" "jrlb_jvavm_wevserver_lauch_config"{
  name_prefix = "jrlb_jvavm_wevserver_lauch_config"
  image_id = ami-0d0f28110d16ee7d6
  instance_type = "t3.micro"
  key_name = "Codepoint"
  security_groups = [var.web_sg_id]

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
 launch_configuration = aws_lauch_configuration.jrlb_jvavm_wevserver_lauch_config.name
 vpc_zone_identifier = [{var.public_subnet1_id}, {var.public_subnet2_id}]
 
 tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  } 
}

resource "aws_lb" "jrlb_jvavm_lb" {
  name = "jrlb_jvavm_lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.sg_alb_id]
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
}*/
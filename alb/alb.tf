
variable "vpc_id" {}
variable "public_subnet1_id" {}
variable "public_subnet2_id" {}
variable "private_subnet1_id" {}
variable "private_subnet2_id" {}
variable "web_sg_id" {}
variable "private_web_sg_id" {}
variable "sg_alb_name" {}
variable "sg_alb_id" {}


resource "aws_launch_template" "jrlb_jvavm_wevserver_lauch_config"{
  name_prefix = "jrlb_jvavm_wevserver_lauch_config"
  image_id = "ami-08b5b3a93ed654d19"
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.web_sg_id]
  }

  user_data = base64encode(<<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd.x86_64
            systemctl start httpd.service
            systemctl enable httpd.service
            echo “Hello World from $(hostname -f)” > /var/www/html/index.html
            EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
        Aluno = "jrlb_jvavm"
        Periodo = "8"
    }
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 10
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }

  ebs_optimized = true
}

resource "aws_lb_target_group" "jrlb_jvavm_target_group"{
  name = "jrlb-jvavm-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

resource "aws_autoscaling_group" "jrlb_jvavm_asg"{
 name = "jrlb_jvavm_asg"
 desired_capacity = 2
 max_size = 4
 min_size = 1
 health_check_type = "EC2"
 vpc_zone_identifier = [var.public_subnet1_id, var.public_subnet2_id]

 launch_template {
    id      = aws_launch_template.jrlb_jvavm_wevserver_lauch_config.id
    version = "$Latest"
  }
}

resource "aws_lb" "jrlb_jvavm_lb" {
  name = "jrlb-jvavm-lb"
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
    target_group_arn = aws_lb_target_group.jrlb_jvavm_target_group.arn
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "lt" {
  name_prefix   = "${var.prefixo}-lt"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name = var.key_name

user_data = base64encode(<<EOF
#!/bin/bash
# Atualiza pacotes
dnf update -y

# Instala o Docker
dnf install -y docker

# Inicia e habilita o Docker
systemctl start docker
systemctl enable docker

# Roda a aplicação diretamente como root (user_data já executa como root)
docker run -d -p 80:3000 jvavm/getting-started:latest

# Escreve um log simples pra debug
echo "Aplicação iniciada pelo user_data" > /home/ec2-user/startup.log
EOF
)


  vpc_security_group_ids = [var.security_group_id]

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.tags, {
      Name = "${var.prefixo}-ec2-asg"
    })
  }

  tags = merge(var.tags, {
    Name = "${var.prefixo}-lt"
  })
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.prefixo}-asg"
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = var.subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.prefixo}-ec2-asg"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
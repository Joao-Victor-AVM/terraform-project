resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group para servidor web"
  vpc_id      = "vpc-05c5b4cc3ecc3b273"
  
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
  vpc_security_group_ids = ["sg-0713682c3468f2c1e"]
  subnet_id       = "subnet-01bbc5886d21d6a18"
  associate_public_ip_address = true 

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Servidor Web Ativo!" > /var/www/html/index.html
              EOF

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}
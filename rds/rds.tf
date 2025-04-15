
variable "private_subnet1_id" {}
variable "private_subnet2_id" {}
variable "rds_sg_id" {}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [var.private_subnet1_id, var.private_subnet2_id]

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
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  backup_retention_period = 7

  tags = {
    Aluno = "jrlb_jvavm"
    Periodo = "8"
  }
}

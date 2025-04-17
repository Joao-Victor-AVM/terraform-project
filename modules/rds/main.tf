resource "aws_db_subnet_group" "this" {
  name       = "${var.prefixo}-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.prefixo}-rds-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier              = "${var.prefixo}-rds"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"

  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name

  vpc_security_group_ids  = [var.security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  backup_retention_period = 7
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false

  tags = merge(var.tags, {
    Name = "${var.prefixo}-rds"
  })
}

resource "aws_db_subnet_group" "prod" {
  name       = "main"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]
}

resource "aws_db_instance" "prod" {
  identifier              = "production"
  db_name                 = var.rds_db_name
  username                = var.rds_username
  password                = var.rds_password
  port                    = "5432"
  instance_class          = var.rds_instance_class
  allocated_storage       = 5
  engine                  = "postgres"
  engine_version          = "15.4"
  db_subnet_group_name    = aws_db_subnet_group.prod.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  storage_type            = "gp2"
  storage_encrypted       = false
  multi_az                = false
  backup_retention_period = 7
  publicly_accessible     = false
  skip_final_snapshot     = true
}

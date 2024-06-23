# CREATE RDS MYSQL INSTANCE
resource "aws_db_instance" "rds-mysql-1" {
  allocated_storage    = 10
  db_name              = "rdsdb1"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin1234"
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  identifier           = "rds-database-1"
  vpc_security_group_ids = [aws_security_group.rds-mysql-sg.id]
  skip_final_snapshot  = true
}


# CREATE RDS MYSQL SUBNET GROUP
resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-groups"
  subnet_ids = [aws_subnet.Private-Subnet-3.id, aws_subnet.Private-Subnet-4.id]

  tags = {
    Name = "rds-subnet-groups"
  }
}
# TRAFFIC FROM APPLICATION TIER TO DATABASE TIER
resource "aws_security_group" "rds-mysql-sg" {
  name        = "rds-mysql-sg"
  description = "rds-mysql-sg"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app-instance-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
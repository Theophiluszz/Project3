
# TRAFFIC FROM ANYWHERE TO THE LOAD BALANCER
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.vpc-1.id

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

  

  tags = {
    Name = "ALB-sg"
  }
}


# TRAFFIC FROM LOAD BALANCER TO INSTANCES IN THE AUTOSCALING GROUP
resource "aws_security_group" "instance-sg" {
  name        = "instance-sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups    = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "INSTANCE-sg"
  }
}


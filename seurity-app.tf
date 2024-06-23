
# SECURITY GROUP - APPLICATION LOAD BALANCER
# TRAFFIC FROM INSTANCES IN PRESENTATION TIER TO THE LOAD BALANCER
resource "aws_security_group" "app-LB-sg" {
  name        = "app-LB-sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.instance-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  

  tags = {
    Name = "app-LB-sg"
  }
}


# TRAFFIC FROM LOAD BALANCER TO INSTANCES IN THE AUTOSCALING GROUP
resource "aws_security_group" "app-instance-sg" {
  name        = "app-instance-sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.app-LB-sg.id]
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
    Name = "APP-INSTANCE-sg"
  }
}


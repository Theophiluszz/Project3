# PRESENTATION TIER

# CREATE APPLICATION LOAD BALANCER
resource "aws_lb" "Alb-1" {
  name               = "alb-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.Public-Subnet-1.id, aws_subnet.Public-Subnet-2.id]

}



# ALB LISTENER
resource "aws_lb_listener" "alb-listener-B1" {
  load_balancer_arn = aws_lb.Alb-1.arn
  port              = "80"
  protocol          = "HTTP"



  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}


# CREATE TARGET GROUP
resource "aws_lb_target_group" "TG" {
  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc-1.id
  

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "alb-tg"
  }
}


# CREATE AUOT-SCALING GROUP
resource "aws_autoscaling_group" "presentation-autoscaling-1" {
  name                      = "Presentation-autoscaling-group"
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "EC2"
  desired_capacity          = 1
  target_group_arns         = [aws_lb_target_group.TG.arn]
  vpc_zone_identifier       = [aws_subnet.Public-Subnet-1.id, aws_subnet.Public-Subnet-2.id]


  launch_template {
    id = aws_launch_template.presentation-LT.id
    version = aws_launch_template.presentation-LT.latest_version
  }
}


# CREATE LAUNCH TEMPLATE
resource "aws_launch_template" "presentation-LT" {
  name = "presentation-LT"
  image_id = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"


  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.instance-sg.id]
  }

    user_data = filebase64("apache.sh")


  

  
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Presentation-LT"
    }
  }

  
}
  




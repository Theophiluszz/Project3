
#  APPLICATION TIER

# CREATE APPLICATION LOAD BALANCER 
resource "aws_lb" "app-alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app-LB-sg.id]
  subnets            = [aws_subnet.Private-Subnet-1.id, aws_subnet.Private-Subnet-2.id]

}



# CREATE ALB LISTENER
resource "aws_lb_listener" "app-alb-listener-1" {
  load_balancer_arn = aws_lb.app-alb.arn
  port              = "80"
  protocol          = "HTTP"



  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tier-tg.arn
  }
}


# CREATE ALB TARGET GROUP
resource "aws_lb_target_group" "app-tier-tg" {
  name        = "app-tier-tg"
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
    Name = "app-tier-tg"
  }
}




# CREATE AUTO-SCALING GROUP
resource "aws_autoscaling_group" "app-autoscaling-tier" {
  name                      = "app-autoscaling-tier"
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "EC2"
  desired_capacity          = 1
  target_group_arns         = [aws_lb_target_group.app-tier-tg.arn]
  vpc_zone_identifier       = [aws_subnet.Private-Subnet-1.id, aws_subnet.Private-Subnet-2.id]


  launch_template {
    id = aws_launch_template.app-tier-LT.id
    version = aws_launch_template.app-tier-LT.latest_version
  }
}



# CREATE LAUNCH TEMPLATE
resource "aws_launch_template" "app-tier-LT" {
  name = "app-tier-LT"
  image_id = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"


  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app-instance-sg.id]
  }

    user_data = filebase64("apache.sh")


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-tier-LT"
    }
  }
}




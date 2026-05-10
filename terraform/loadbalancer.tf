resource "aws_lb" "three-tier-internet-alb" {
  name               = "three-tier-internet-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.three-tier-internet-alb.id]
  subnets            = [aws_subnet.three-tier-web-public-subnet-1.id]

  tags = {
    name = "three-tier-internet-alb"
  }
}

resource "aws_lb_target_group" "three-tier-internet-lb-tg" {
  name     = "three-tier-internet-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier-vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.three-tier-internet-alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.three-tier-internet-lb-tg.arn
  }
}

resource "aws_lb" "three-tier-internal-alb" {
  name               = "three-tier-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.three-tier-internal-alb.id]
  subnets            = [aws_subnet.three-tier-app-private-subnet-1.id]

  tags = {
    name = "three-tier-internet-alb"
  }
}

resource "aws_lb_target_group" "three-tier-internal-lb-tg" {
  name     = "three-tier-internal-alb"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.three-tier-vpc.id
}

resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.three-tier-internal-alb.arn
  port              = "5000"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.three-tier-internal-lb-tg.arn
  }
}


git add .
git commit -m "add LoadBalancer"
git push project2 main 
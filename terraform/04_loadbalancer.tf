# Production Load Balancer 
resource "aws_lb" "production" {
  name = "${var.ecs_cluster_name}-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.load-balancer.id]
  subnets = [ aws_subnet.public-1.id, aws_subnet.public-2.id ]
}

# Target group 

resource "aws_lb_target_group" "default" {
  name = "${var.ecs_cluster_name}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

# Listener - to redirect traffic from LB to TG 
resource "aws_alb_listener" "ecs-alb-http-listener" {
  load_balancer_arn = aws_lb.production.arn
  port = "80"
  protocol = "HTTP"
  depends_on = [ aws_lb_target_group.default ]

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

resource "aws_lb" "ktb_11_chatbot_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "ktb_11_chatbot_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_listener" "ktb_11_chatbot_listener" {
  load_balancer_arn = aws_lb.ktb_11_chatbot_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ktb_11_chatbot_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "ktb_11_chatbot_worker" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.ktb_11_chatbot_tg.arn
  target_id        = var.instance_ids[count.index]
  port             = var.target_group_port
}

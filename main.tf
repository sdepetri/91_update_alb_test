resource "aws_lb" "alb" {
  name                             = var.name

  internal                         = var.is_internal
  load_balancer_type               = "application"

  security_groups                  = [var.alb_sg]
  subnets                          = var.subnets_id
  enable_deletion_protection       = var.delete_protection
  enable_cross_zone_load_balancing = var.cross_zone_lb

  idle_timeout                     = var.idle_timeout
  drop_invalid_header_fields       = var.drop_invalid_header_fields

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    enabled = true
    prefix  = "${var.name}-alb"
  }

  tags = var.tags
}

resource "aws_lb_target_group" "default_tg" {
  name     = "${var.name}-default-80-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener_443" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_cert_arn

  default_action {
    target_group_arn = aws_lb_target_group.default_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.default_tg.arn
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener_certificate" "extra-certs" {
  count           = length(var.additional_certs)
  listener_arn    = aws_lb_listener.listener_443.arn
  certificate_arn = element(var.additional_certs, count.index)
}

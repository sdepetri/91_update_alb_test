output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value = aws_lb.alb.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix of the Application Load Balancer"
  value = aws_lb.alb.arn_suffix
}

output "alb_name" {
  description = "The name of the Application Load Balancer"
  value = aws_lb.alb.name
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value = aws_lb.alb.dns_name
}

output "alb_hosted_zone_id" {
  description = "The canonical hosted zone ID of the Application Load Balancer"
  value = aws_lb.alb.zone_id
}

output "alb_listener_80_arn" {
  description = "The ARN of the HTTP (port 80) listener"
  value = aws_lb_listener.listener_80.arn
}

output "alb_listener_443_arn" {
  description = "The ARN of the HTTPS (port 443) listener"
  value = aws_lb_listener.listener_443.arn
}

output "alb_target_group_arn" {
  description = "The ARN of the target group"
  value = aws_lb_target_group.default_tg.arn
}

output "alb_target_group_arn_suffix" {
  description = "The ARN suffix of the target group"
  value = aws_lb_target_group.default_tg.arn_suffix
}

output "alb_dns_name" {
  value       = aws_lb.ktb_11_chatbot_lb.dns_name
}

output "alb_zone_id" {
  value       = aws_lb.ktb_11_chatbot_lb.zone_id
}

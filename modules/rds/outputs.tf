output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.ktb_11_chatbot_db.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.ktb_11_chatbot_db.id
}

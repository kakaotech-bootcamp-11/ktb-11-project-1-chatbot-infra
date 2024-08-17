output "ktb_11_chatbot_master_sg_id" {
  value = aws_security_group.ktb_11_chatbot_master_sg.id
}

output "ktb_11_chatbot_worker_sg_id" {
  value = aws_security_group.ktb_11_chatbot_worker_sg.id
}

output "ktb_11_chatbot_rds_sg_id" {
  value = aws_security_group.ktb_11_chatbot_rds_sg.id
}

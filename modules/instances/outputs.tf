output "master_instance_id" {
  value = aws_instance.ktb_11_chatbot_master.id
}

output "worker1_instance_id" {
  value = aws_instance.ktb_11_chatbot_worker1.id
}

output "worker2_instance_id" {
  value = aws_instance.ktb_11_chatbot_worker2.id
}

output "worker3_instance_id" {
  value = aws_instance.ktb_11_chatbot_worker3.id
}

output "master_public_ip" {
  value = aws_instance.ktb_11_chatbot_master.public_ip
}

output "worker1_public_ip" {
  value = aws_instance.ktb_11_chatbot_worker1.public_ip
}

output "worker2_public_ip" {
  value = aws_instance.ktb_11_chatbot_worker2.public_ip
}

output "worker3_public_ip" {
  value = aws_instance.ktb_11_chatbot_worker3.public_ip
}

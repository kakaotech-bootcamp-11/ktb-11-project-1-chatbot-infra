output "vpc_id" {
  value = aws_vpc.ktb_11_chatbot_vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "public_subnet_c_id" {
  value = aws_subnet.public_c.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

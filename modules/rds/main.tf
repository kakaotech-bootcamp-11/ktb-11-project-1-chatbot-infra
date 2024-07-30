resource "aws_db_instance" "ktb_11_chatbot_db" {
  identifier           = "ktb11project"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.ktb_11_chatbot_db_sg.name
  vpc_security_group_ids = [var.security_group_id]

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible    = true

  tags = {
    Name = "ktb-11-chatbot-db"
  }
}

resource "aws_db_subnet_group" "ktb_11_chatbot_db_sg" {
  name       = "ktb-11-chatbot-db-subnet-group"
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_c_id]

  tags = {
    Name = "ktb-11-chatbot-db-subnet-group"
  }
}

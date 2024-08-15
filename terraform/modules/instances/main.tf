resource "aws_instance" "ktb_11_chatbot_master" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_a_id
  security_groups = [var.master_security_group_id]
  key_name      = var.key_name

  tags = {
    Name = "ktb-11-chatbot-master"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_a_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name

  tags = {
    Name = "ktb-11-chatbot-worker1"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_c_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name

  tags = {
    Name = "ktb-11-chatbot-worker2"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker3" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_c_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name

  tags = {
    Name = "ktb-11-chatbot-worker3"
  }
}

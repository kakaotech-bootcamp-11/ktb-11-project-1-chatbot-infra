resource "aws_instance" "ktb_11_chatbot_master" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_a_id
  security_groups = [var.master_security_group_id]
  key_name      = var.key_name
  iam_instance_profile = var.master_instance_profile_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname master
              EOF

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "ktb-11-chatbot-master"
    "kubernetes.io/cluster/kubernetes" = "shared"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_c_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name
  iam_instance_profile = var.worker_instance_profile_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname worker1
              EOF

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "ktb-11-chatbot-worker1"
    "kubernetes.io/cluster/kubernetes" = "shared"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_c_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name
  iam_instance_profile = var.worker_instance_profile_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname worker2
              EOF

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "ktb-11-chatbot-worker2"
    "kubernetes.io/cluster/kubernetes" = "shared"
  }
}

resource "aws_instance" "ktb_11_chatbot_worker3" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_c_id
  security_groups = [var.worker_security_group_id]
  key_name      = var.key_name
  iam_instance_profile = var.worker_instance_profile_name
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname worker3
              EOF

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "ktb-11-chatbot-worker3"
    "kubernetes.io/cluster/kubernetes" = "shared"
  }
}

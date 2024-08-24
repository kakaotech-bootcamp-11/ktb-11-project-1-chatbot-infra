resource "aws_security_group" "ktb_11_chatbot_master_sg" {
  vpc_id = var.vpc_id

  # SSH 접근을 허용
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 외부에서 HTTP 트래픽 허용 (포트 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 외부에서 HTTPS 트래픽 허용 (포트 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # IP-in-IP 트래픽 허용
    ingress {
      from_port   = 4
      to_port     = 4
      protocol    = "4"  # IP-in-IP 프로토콜
      cidr_blocks = [var.vpc_cidr]
    }

  # Kubernetes API 서버 접근을 특정 서브넷으로 제한
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [
      var.public_subnet_a_cidr,
      var.public_subnet_c_cidr
    ]
  }

  # etcd 서버 클라이언트 API 접근 허용 (마스터 노드에만 필요)
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]  # 마스터 노드 내 통신만 허용
  }

  # Kubelet API 접근 허용
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # kube-controller-manager 접근 허용 (마스터 노드에만 필요)
  ingress {
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # kube-scheduler 접근 허용 (마스터 노드에만 필요)
  ingress {
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ktb-11-chatbot-master-sg"
  }
}

resource "aws_security_group" "ktb_11_chatbot_worker_sg" {
  vpc_id = var.vpc_id

  # SSH 접근을 허용
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 외부에서 HTTP 트래픽 허용 (포트 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 외부에서 HTTPS 트래픽 허용 (포트 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # IP-in-IP 트래픽 허용
  ingress {
    from_port   = 4
    to_port     = 4
    protocol    = "4"  # IP-in-IP 프로토콜
    cidr_blocks = [var.vpc_cidr]
  }

  # Kubelet API 접근 허용
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # NodePort 서비스 접근 허용 (모든 워커 노드에 필요)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ktb-11-chatbot-worker-sg"
  }
}

resource "aws_security_group" "ktb_11_chatbot_rds_sg" {
  vpc_id = var.vpc_id

    # MySQL 접근 허용 (VPC 내부에서만)
    ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]  # VPC 내부 접근만 허용
    }

  # 모든 아웃바운드 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ktb-11-chatbot-rds-sg"
  }
}

# 마스터 노드에서 워커 노드로의 통신 허용
resource "aws_security_group_rule" "master_to_worker" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ktb_11_chatbot_worker_sg.id
  source_security_group_id = aws_security_group.ktb_11_chatbot_master_sg.id
}

# 워커 노드에서 마스터 노드로의 통신 허용
resource "aws_security_group_rule" "worker_to_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ktb_11_chatbot_master_sg.id
  source_security_group_id = aws_security_group.ktb_11_chatbot_worker_sg.id
}

# 워커 노드 간의 모든 포트 통신 허용
resource "aws_security_group_rule" "worker_sg_self" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ktb_11_chatbot_worker_sg.id
  source_security_group_id = aws_security_group.ktb_11_chatbot_worker_sg.id
}

# RDS와 마스터 노드 간의 MySQL 포트 통신 허용
resource "aws_security_group_rule" "rds_master_sg_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ktb_11_chatbot_rds_sg.id
  source_security_group_id = aws_security_group.ktb_11_chatbot_master_sg.id
}

# RDS와 워커 노드 간의 MySQL 포트 통신 허용
resource "aws_security_group_rule" "rds_worker_sg_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ktb_11_chatbot_rds_sg.id
  source_security_group_id = aws_security_group.ktb_11_chatbot_worker_sg.id
}

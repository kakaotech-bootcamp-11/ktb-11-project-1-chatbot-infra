resource "aws_iam_role" "master_role" {
  name = var.master_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "master_policy" {
  name   = "ktb_11_chatbot_master_policy"
  role   = aws_iam_role.master_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVolumes",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:ModifyInstanceAttribute",
          "ec2:ModifyVolume",
          "ec2:AttachVolume",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateRoute",
          "ec2:DeleteRoute",
          "ec2:DeleteSecurityGroup",
          "ec2:DeleteVolume",
          "ec2:DetachVolume",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DescribeVpcs",
          "elasticloadbalancing:*",
          "iam:CreateServiceLinkedRole",
          "kms:DescribeKey"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "worker_role" {
  name = var.worker_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "worker_policy" {
  name   = "ktb_11_chatbot_worker_policy"
  role   = aws_iam_role.worker_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "master_instance_profile" {
  name = "ktb_11_chatbot_master_instance_profile"
  role = aws_iam_role.master_role.name
}

resource "aws_iam_instance_profile" "worker_instance_profile" {
  name = "ktb_11_chatbot_worker_instance_profile"
  role = aws_iam_role.worker_role.name
}

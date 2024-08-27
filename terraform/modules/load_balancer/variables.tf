variable "lb_name" {
  description = "ALB 이름"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "서브넷 IDs"
  type        = list(string)
}

variable "security_groups" {
  description = "보안 그룹 IDs"
  type        = list(string)
}

variable "target_group_name" {
  description = "대상 그룹 이름"
  type        = string
}

variable "target_group_port" {
  description = "대상 그룹 포트"
  type        = number
}

variable "instance_ids" {
  description = "인스턴스 IDs"
  type        = list(string)
}

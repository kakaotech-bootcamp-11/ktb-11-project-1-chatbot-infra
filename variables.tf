variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the public subnet in availability zone a"
  default     = "10.0.1.0/24"
}

variable "public_subnet_c_cidr" {
  description = "The CIDR block for the public subnet in availability zone c"
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for the private subnet in availability zone a"
  default     = "10.0.3.0/24"
}

variable "private_subnet_c_cidr" {
  description = "The CIDR block for the private subnet in availability zone c"
  default     = "10.0.4.0/24"
}

variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "ap-northeast-2"
}

variable "instance_type" {
  description = "The type of instance to use"
  default     = "t3.small"
}

variable "ami" {
  description = "The AMI to use for the instances"
  default     = "ami-062cf18d655c0b1e8"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instance"
  type        = string
  default     = "ktb-11-chatbot-key"
}

variable "db_name" {
  description = "The name of the database"
  default     = "ktbchatbot"
}

variable "db_username" {
  description = "The username for the database"
  default     = ""
}

variable "db_password" {
  description = "The password for the database"
  default     = ""
}

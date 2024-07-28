variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the public subnet in availability zone a"
  type        = string
}

variable "public_subnet_c_cidr" {
  description = "The CIDR block for the public subnet in availability zone c"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

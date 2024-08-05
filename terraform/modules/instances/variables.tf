variable "ami" {
  description = "The AMI to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instance"
  type        = string
}

variable "public_subnet_a_id" {
  description = "The ID of the public subnet in availability zone a"
  type        = string
}

variable "public_subnet_c_id" {
  description = "The ID of the public subnet in availability zone c"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "private_subnet_a_id" {
  description = "The ID of the private subnet in availability zone a"
  type        = string
}

variable "private_subnet_c_id" {
  description = "The ID of the private subnet in availability zone c"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

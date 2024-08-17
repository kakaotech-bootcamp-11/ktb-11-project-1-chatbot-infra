output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_a_id" {
  description = "The ID of the public subnet in availability zone a"
  value       = module.vpc.public_subnet_a_id
}

output "public_subnet_c_id" {
  description = "The ID of the public subnet in availability zone c"
  value       = module.vpc.public_subnet_c_id
}

output "private_subnet_a_id" {
  description = "The ID of the private subnet in availability zone a"
  value       = module.vpc.private_subnet_a_id
}

output "private_subnet_c_id" {
  description = "The ID of the private subnet in availability zone c"
  value       = module.vpc.private_subnet_c_id
}

output "instance_master_security_group_id" {
  description = "The ID of the instance security group"
  value       = module.security_groups.ktb_11_chatbot_master_sg_id
}

output "instance_worker_security_group_id" {
  description = "The ID of the instance security group"
  value       = module.security_groups.ktb_11_chatbot_worker_sg_id
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = module.security_groups.ktb_11_chatbot_rds_sg_id
}

output "master_instance_id" {
  description = "The ID of the master instance"
  value       = module.instances.master_instance_id
}

output "worker1_instance_id" {
  description = "The ID of the worker1 instance"
  value       = module.instances.worker1_instance_id
}

output "worker2_instance_id" {
  description = "The ID of the worker2 instance"
  value       = module.instances.worker2_instance_id
}

output "worker3_instance_id" {
  description = "The ID of the worker3 instance"
  value       = module.instances.worker3_instance_id
}

output "master_public_ip" {
  description = "The public IP of the master instance"
  value       = module.instances.master_public_ip
}

output "worker1_public_ip" {
  description = "The public IP of the worker1 instance"
  value       = module.instances.worker1_public_ip
}

output "worker2_public_ip" {
  description = "The public IP of the worker2 instance"
  value       = module.instances.worker2_public_ip
}

output "worker3_public_ip" {
  description = "The public IP of the worker3 instance"
  value       = module.instances.worker3_public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = module.rds.rds_instance_id
}

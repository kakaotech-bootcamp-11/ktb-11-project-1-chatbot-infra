provider "aws" {
#   profile = "terraform-user"
  region  = var.region
  assume_role {
    role_arn = "arn:aws:iam::851725627278:role/TerraformAssumedRole"
  }
}

module "iam_roles" {
  source = "./modules/iam_roles"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_c_cidr = var.public_subnet_c_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_c_cidr = var.private_subnet_c_cidr
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_c_cidr = var.public_subnet_c_cidr
}

module "instances" {
  source             = "./modules/instances"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_c_id = module.vpc.public_subnet_c_id
  master_security_group_id  = module.security_groups.ktb_11_chatbot_master_sg_id
  worker_security_group_id = module.security_groups.ktb_11_chatbot_worker_sg_id
  master_instance_profile_name = module.iam_roles.master_instance_profile
  worker_instance_profile_name = module.iam_roles.worker_instance_profile
}

module "rds" {
  source             = "./modules/rds"
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_c_id = module.vpc.private_subnet_c_id
  security_group_id  = module.security_groups.ktb_11_chatbot_rds_sg_id
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  lb_name            = "ktb-11-chatbot-lb"
  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_c_id]
  security_groups    = [module.security_groups.ktb_11_chatbot_worker_sg_id]
  target_group_name  = "ktb-11-chatbot-tg"
  target_group_port  = 30001
  instance_ids       = [
    module.instances.worker1_instance_id,
    module.instances.worker2_instance_id,
    module.instances.worker3_instance_id
  ]
}

resource "aws_route53_record" "chatbot_alb" {
  zone_id = var.route53_zone_id
  name    = "ktb-chatbot.shop"
  type    = "A"

  alias {
    name                   = module.load_balancer.alb_dns_name
    zone_id                = module.load_balancer.alb_zone_id
    evaluate_target_health = true
  }
}

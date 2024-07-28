provider "aws" {
  profile = "terraform-user"
  region  = var.region
  assume_role {
    role_arn = "arn:aws:iam::851725627278:role/TerraformAssumedRole"
  }
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_c_cidr = var.public_subnet_c_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "instances" {
  source             = "./modules/instances"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_c_id = module.vpc.public_subnet_c_id
  security_group_id  = module.security_groups.security_group_id
}

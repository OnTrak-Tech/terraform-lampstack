terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  
  tags = var.tags
}

module "security" {
  source = "./modules/security"
  
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "web" {
  source = "./modules/web"
  
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  web_security_group_id = module.security.web_security_group_id
  key_name              = var.key_name
  instance_type         = var.web_instance_type
  
  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
  
  tags = var.tags
}
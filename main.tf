provider "aws" {
  region     = "us-east-1"
  //access_key = "" // Colocar os valores quando for providenciar o serviço
  //secret_key = "" // Colocar os valores quando for providenciar o serviço
}

resource "aws_s3_bucket" "rlc_bsvs_bucket" {
  bucket = "jrlb-jvavm-bkt-s3"
}

resource "aws_key_pair" "meu_ssh" {
  key_name   = "minha-chave-ssh"
  public_key = file("${path.module}/keys/minhachave.pub")
}

locals {
  prefixo = "jrlb-jvavm"
  tags = {
    Alunos = "jrlb"
    Periodo = "8"
  }
}

module "vpc" {
  source   = "./modules/vpc"
  prefixo  = local.prefixo
  vpc_cidr = "10.0.0.0/16"
  tags     = local.tags
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  subnet_cidrs          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b"]
  public_subnet_indexes = [0, 1]
  prefixo               = local.prefixo
  tags                  = local.tags
}

module "igw" {
  source  = "./modules/internet_gateway"
  vpc_id  = module.vpc.vpc_id
  prefixo = local.prefixo
  tags    = local.tags
}

module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.igw.igw_id
  public_subnet_ids   = slice(module.subnets.subnet_ids, 0, 2)
  private_subnet_ids  = slice(module.subnets.subnet_ids, 2, 4)
  prefixo             = local.prefixo
  tags                = local.tags
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  prefixo = local.prefixo
  tags    = local.tags
}

module "autoscaling" {
  source             = "./modules/autoscaling"
  prefixo            = local.prefixo
  tags               = local.tags
  subnet_ids         = slice(module.subnets.subnet_ids, 0, 2) # públicas
  security_group_id  = module.security_groups.sg_ec2_public
  key_name = aws_key_pair.meu_ssh.key_name
}

module "alb" {
  source             = "./modules/alb"
  prefixo            = local.prefixo
  tags               = local.tags
  subnet_ids         = slice(module.subnets.subnet_ids, 0, 2)
  security_group_id  = module.security_groups.sg_alb
  vpc_id             = module.vpc.vpc_id
  asg_name           = module.autoscaling.asg_name
}

module "rds" {
  source             = "./modules/rds"
  prefixo            = local.prefixo
  tags               = local.tags
  subnet_ids         = slice(module.subnets.subnet_ids, 2, 4)
  security_group_id  = module.security_groups.sg_rds
  db_username        = "admin"
  db_password        = "applicPass1001!"
  db_name            = "appbase"
}

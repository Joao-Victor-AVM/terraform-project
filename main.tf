provider "aws" {
  region = "us-east-1"
}
/*
module "vpc"{
  source = "./vpc"
  
}

module "sg"{
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}

module "alb"{
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  private_subnet1_id = module.vpc.private_subnet1_id
  private_subnet2_id = module.vpc.private_subnet2_id
  web_sg_id = module.sg.web_sg
  private_web_sg_id = module.sg.private_web_sg
  sg_alb_name = module.sg.sg_alb_name
  sg_alb_id = module.sg.sg_alb_id 
}

module "rds"{
  source = "./rds"
  private_subnet1_id = module.vpc.private_subnet1_id
  private_subnet2_id = module.vpc.private_subnet2_id
  rds_sg_id = module.sg.rds_sg
}
*/

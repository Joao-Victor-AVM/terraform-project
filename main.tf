provider "aws" {
  region = "us-east-1"
}
/*
module "vpc"{
  source = "./vpc"
  
}

module "instance"{
  source = "./instances"
  vpc_id = module.vpc.vpc_id
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  private_subnet1_id = module.vpc.private_subnet1_id
  private_subnet2_id = module.vpc.private_subnet2_id
}*/

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
  public_subnet_id = module.vpc.public_subnetid
  private_subnet1_id = module.vpc.private_subnet1_id
}*/

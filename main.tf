provider "aws" {
  region = "us-east-1"
}

module "vpc"{
  source = "./vpc"
  
}

module "instance"{
  source = "./instances"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnetid
}

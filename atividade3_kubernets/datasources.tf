data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:Name"
    values = ["myvpc-cdcp"]
  }
}

data "aws_subnets" "eks_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }
}

data "aws_subnet" "eks_subnet_1" {
  id = data.aws_subnets.eks_subnets.ids[0]
}

data "aws_subnet" "eks_subnet_2" {
  id = data.aws_subnets.eks_subnets.ids[1]
}

data "aws_eks_cluster" "eks" {
  name = "eksDeepDiveFrankfurt"
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks.name
}

data "aws_security_group" "eks_sg" {
  id = "sg-0e50cabbf08b874e2"
}


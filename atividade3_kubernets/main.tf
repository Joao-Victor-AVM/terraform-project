data "aws_eks_cluster" "eks" {
  name = "eksDeepDive"
}

data "aws_eks_cluster_auth" "eks" {
  name = data.aws_eks_cluster.eks.name
}

data "aws_vpc" "vpc" {
  id = data.aws_eks_cluster.eks.vpc_config[0].vpc_id
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

# Referenciando o Security Group existente
data "aws_security_group" "eks_sg" {
  id = "sg-062170f6c5c2a2276"
}

# Recurso do Node Group
resource "aws_eks_node_group" "node_group" {
  cluster_name    = data.aws_eks_cluster.eks.name
  node_group_name = "nodeGroup1"
  node_role_arn   = var.node_role_arn
  subnet_ids      = data.aws_subnets.subnets.ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.small"]

  ami_type = "AL2_x86_64"

    tags = {
    Aluno   = "jrlb"
    Periodo = "8"
  }
}

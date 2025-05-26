resource "aws_eks_node_group" "node_group_dp001" {
  cluster_name    = data.aws_eks_cluster.eks.name
  node_group_name = "nodeGroupDP001"
  node_role_arn   = "arn:aws:iam::325583868777:role/EKSNodeGroupRole"
  subnet_ids      = data.aws_subnets.eks_subnets.ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.small"]
  ami_type       = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = "cdcp-2305"
  }

  tags = {
    Aluno = "jrlb-jvavm"
    Periodo = "8"
  }
}

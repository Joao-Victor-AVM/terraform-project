output "cluster_name" {
  value = data.aws_eks_cluster.eks.name
}

output "vpc_id" {
  value = data.aws_vpc.eks_vpc.id
}

output "subnet_ids" {
  value = data.aws_subnets.eks_subnets.ids
}

output "security_group_id" {
  value = data.aws_security_group.eks_sg.id
}

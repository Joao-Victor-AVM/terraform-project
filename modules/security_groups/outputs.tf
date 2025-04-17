output "sg_ec2_public" {
  value = aws_security_group.ec2_public.id
}

output "sg_ec2_private" {
  value = aws_security_group.ec2_private.id
}

output "sg_rds" {
  value = aws_security_group.rds.id
}

output "sg_alb" {
  value = aws_security_group.alb.id
}

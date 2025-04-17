variable "prefixo" {}
variable "tags" {
  type = map(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {}

variable "vpc_id" {}

variable "asg_name" {}

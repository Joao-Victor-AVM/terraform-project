variable "vpc_id" {}
variable "igw_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "prefixo" {}
variable "tags" {
  type = map(string)
}

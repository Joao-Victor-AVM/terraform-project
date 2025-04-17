variable "vpc_id" {}
variable "subnet_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "public_subnet_indexes" {
  type = list(number)
}
variable "prefixo" {}
variable "tags" {
  type = map(string)
}

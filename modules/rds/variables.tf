variable "prefixo" {}
variable "tags" {
  type = map(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "db_name" {}

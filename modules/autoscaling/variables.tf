variable "prefixo" {}
variable "tags" {
  type = map(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "key_name" {
  description = "Nome do par de chaves SSH"
  type        = string
}

variable "security_group_id" {}

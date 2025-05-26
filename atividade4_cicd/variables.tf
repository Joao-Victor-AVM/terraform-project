variable "github_repo" {
  description = "Repositório GitHub no formato owner/repo"
  type        = string
}

variable "github_token" {
  description = "Token de acesso pessoal do GitHub (PAT)"
  type        = string
  sensitive   = true
}

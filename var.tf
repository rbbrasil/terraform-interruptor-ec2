variable "caminho_par_chaves" {
  description = "Caminho relativo a chave SSH publica"
}

variable "nome_bucket" {
  description = "Nome publico e unico do bucket S3"
}

variable "api_nome" {}
variable "api_caminho" {
  description = "Final da URL do endpoint /xyz"
}

variable "lambda_nome" {}

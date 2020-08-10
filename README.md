# Interruptor de EC2 via API Gateway e Lambda

Módulo experimental para laboratório e repasse de conhecimento interno.

## O quê ele faz
Cria uma página HTML em um S3 que permite ligar ou desligar uma instância AWS EC2.

## Como ele faz
A operação de ligar ou desligar a instância é realizar a partir de uma chamada autenticada ao API Gateway através de uma página HTML estática hospedada em um S3. Ao submeter o formulário que contém o ID da instância EC2, o Endpoint do API Gateway e a chave de acesso, a requisição será encaminhada à uma função Lambda que ligará ou desligará a instância especificada.

Serão criados *XX* recursos ao total (ver saída do comando `terraform plan`). Os principais recursos são:
- Uma instância Linux EC2
- Um API Gateway com CORS habilitado
- Um bucket S3 público que hospedará uma página HTML estática
- Uma função serverless Lambda integrada ao API Gateway

### Parametrização
```hcl
module "interruptor" {
  source = "git::https://github.com/rbbrasil/terraform-interruptor-ec2"

  caminho_par_chaves = "chave_ssh.pub"
  nome_bucket        = "nome-bucket-s3"
  api_nome           = "nome-api-gateway"
  api_caminho        = "nome-recurso-api"
  lambda_nome        = "nome-funcao-lambda"
}

#### Output
```
output "ip_servidor_inutil" {
  value = module.interruptor.ip_servidor_inutil
}

output "hostname_servidor_inutil" {
  value = module.interruptor.hostname_servidor_inutil
}

output "id_servidor_inutil" {
  value = module.interruptor.id_servidor_inutil
}

output "endpoint_s3" {
  value = module.interruptor.endpoint_s3
}

output "endpoint_api" {
  value = module.interruptor.endpoint_api
}

output "api_key" {
  value = module.interruptor.api_key
}
```

### Execução
Crie um arquivo `main.tf` contendo o conteúdo descrito acima, parametrizado de acordo com seu ambiente local e execute os seguintes comandos:
```
$ terraform init
$ terraform plan
$ terraform apply
```
(testado com Terraform v0.12.26)

#### Executando com o cURL
Para fins de testes, pode ser substituído o HTML do bucket S3 pelo cURL e executar a seguinte chamada:
```sh
$ curl -X POST [ENDPOINT_DO_API_GATEWAY] -d '{"id": "i-0f5a34460bc33b735", "op": "on"}' -H 'x-api-key: CHAVE_DA_API' -q
```

## Dependências
### Par de chaves SSH
É necessário criar um par de chaves SSH para criar e conectar à instância EC2:
```sh
$ ssh-keygen -t rsa -b 2048 -C "exemplo@laboratorio" -f chave_ssh
```
Atentar para o nome do arquivo criado. Ele deverá ser o mesmo utilizado no parâmetro da chamada do módulo Terraform.

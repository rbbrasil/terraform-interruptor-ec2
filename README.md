# Interruptor de EC2 via API Gateway e Lambda

Módulo experimental para laboratório e repasse de conhecimento interno.

## O quê ele faz
Liga e desliga instâncias AWS EC2.

## Como ele faz
Através de uma chamada autenticada ao API Gateway através de uma página HTML estática hospedada em um S3 que é integrada a uma função Lambda que liga ou desliga uma instância EC2.

Serão criados *XX* recursos, sendo
- Uma instância Linux EC2
- Um API Gateway com CORS habilitado
- Um bucket S3 público que hospedará uma página HTML estática
- Uma função serverless Lambda integrada ao API Gateway

A página HTML irá realizar um `POST` em um endpoint do API Gateway protegido por uma chave que deverá ser enviada no cabeçalho do pacote com o nome `x-api-key`.

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
```

### Execução
(testado com Terraform v0.12.26)
```
$ terraform init
$ terraform plan
$ terraform apply
```

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

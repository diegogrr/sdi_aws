# EC2: Projeto 01

## Objetivo
Implantar um servidor WEB utilizando uma instância EC2 pelo console de gerenciamento da AWS. Estudar sobre _user-data_ e _meta-data_.

## AMI
Amazon Linux 2

## Detalhamento do script para user-data
Atualizar o repositório e pacotes do Linux.
```shell
yum update -y
```
Instalar o Apache
```shell
yum install -y httpd
```



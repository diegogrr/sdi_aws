# EC2: Projeto 01

## Objetivo
Implantar um servidor WEB utilizando uma instância EC2 pelo console de gerenciamento da AWS. Estudar sobre _user-data_ e _meta-data_.

## Criar a Instância EC2
Acesse a categoria Computação, serviço EC2.
![etapa01](https://github.com/diegogrr/sdi_aws/blob/43a0cadb893caa18f10a72edef71cef0d7b1f21f/EC2/ec2_p01_WebServer/assets/ec2_p01_img_01.gif)

## AMI
Amazon Linux 2

## Detalhamento do script para user-data
Atualizar todos os pacotes instalados.
```shell
yum update -y
```
Instalar a versão mais recente do servidor Web Apache (httpd)
```shell
yum install -y httpd
```
O Apache não inicia automaticamente no Amazon Linux depois que a instalação é concluída. O comando abaixo inicia o processo do Apache.
```shell
systemctl start httpd
```
Para ativar o serviço para iniciar na inicialização do Sistema Operacional.
```shell
systemctl enable httpd
```
Criar a variável de ambiente *EC2ID* para armazenar o ID da instância obtido a partir do _meta-data_.
```shell
EC2ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
```
Criar o arquivo *index.txt* cujo conteúdo é uma página html.
```shell
echo '<html><center><h1>O ID desta instancia Amazon EC2: EC2ID</h1></center></html>' > /var/www/html/index.txt
```
Cria o arquivo *index.html* a partir do arquivo *index.txt*, substituindo o texto *EC2ID* pelo conteúdo da variável de ambiente *EC2ID*.
```shell
sed "s/EC2ID/$EC2ID/" /var/www/html/index.txt > /var/www/html/index.html
```
Saiba mais sobre o utilitário *sed* neste [link](https://man7.org/linux/man-pages/man1/sed.1p.html).
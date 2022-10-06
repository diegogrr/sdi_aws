# EC2: Projeto 01

## Objetivo
Implantar um servidor WEB utilizando uma instância EC2 pelo console de gerenciamento da AWS. Estudar sobre _user-data_ e _meta-data_.

## Criar a Instância EC2
1. Acesse a categoria Computação, serviço EC2.

![im01](https://github.com/diegogrr/sdi_aws/blob/43a0cadb893caa18f10a72edef71cef0d7b1f21f/EC2/ec2_p01_WebServer/assets/ec2_p01_img_01.gif)

2. Dê um nome para instância. 
3. Selecione a AMI Amazon Linux 2.
4. Selecione o tipo de instância (ex. t3.micro) 
5. Selecione o par de chaves que você pretende utilizar para acessar a instância remotamente.

![im02](https://github.com/diegogrr/sdi_aws/blob/a384e0fedf906ebdbdf6fc3adfdeb1cb8c9c8025/EC2/ec2_p01_WebServer/assets/ec2_p01_img_02.gif)

6. Na seção Configuração de Rede, selecione a VPC de sua escolha ou mantenha a VPC padrão.
7. Selecione um sub-rede pública.
8. Habilite a opção de atribuir ip público automaticamente.
9. Crie um grupo de segurança e adicione a regra de entrada para o tipo HTTP, tipo de origem: qualquer lugar (0.0.0.0/0)

![im03](https://github.com/diegogrr/sdi_aws/blob/26df8e901fd3f1120713576b70b298fa093fff92/EC2/ec2_p01_WebServer/assets/ec2_p01_img_03.gif)

10. Mantenha o armazenamento sugerido.
11. Insira o conteúdo do script *`sc2_p01.sh`* no campo Dados do Usuário (_user-data_).

![im04](https://github.com/diegogrr/sdi_aws/blob/26df8e901fd3f1120713576b70b298fa093fff92/EC2/ec2_p01_WebServer/assets/ec2_p01_img_04.gif)

12. Clique em **Executar instância**

Pronto! Instância lançada com sucesso!

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
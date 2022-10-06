#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id) 
echo '<html><center><h1>O ID desta instancia Amazon EC2 eh: EC2ID</h1></center></html>' > /var/www/html/index.txt
sed "s/EC2ID/$EC2ID/" /var/www/html/index.txt > /var/www/html/index.html
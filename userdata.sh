#!/bin/sh
sudo yum update -y
sudo yum upgrade -y

sudo yum install httpd -y

sudo systemctl enable httpd
sudo systemctl start httpd

cd /var/www/html
sudo aws s3 cp s3://opendoorsbucket123/typing/ . --recursive

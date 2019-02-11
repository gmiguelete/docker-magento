#!/bin/bash

#Welcome 
echo Welcome to bootstrap:

echo Docker Compose:

sudo docker-compose up --build -d

read -p 'directory of magento? (default: /storage/magento ): ' directory

if [ "$directory" = "" ]
then
   directory=${VARIABLE:-/storage/magento} 
fi

if [ ! -d "$directory" ]; then
  echo "this directory does't exist."
exit
fi

file=${VARIABLE:-/index.php} 

if [ ! -f "$directory$file" ]; then
  echo "there is no magento on" $directory
exit
fi

echo 'magento directory:' $directory


#Permission folders
echo setting Permissions folder
sudo docker exec orange_php-7 bash -c "cd $directory && chmod -R 777 generated/ var/ app/etc/ pub/"


#config Nginx
echo config nginx:

read -p 'host name?: (default: dev.magento.com.br )' hostName

if [ "$hostName" = "" ]
then
  hostName=${VARIABLE:-dev.magento.com.br} 
fi

sudo docker exec orange_nginx bash -c ' echo "server {
	    listen 80;
	    listen 443 ssl;

	    ssl_certificate /etc/nginx/ssl/nginx.crt;
	    ssl_certificate_key /etc/nginx/ssl/nginx.key;

	    server_name '$hostName';
	    index index.php index.html;
		
	    set \$MAGE_ROOT '$directory';
	    set \$MAGE_MODE default;

	    include /etc/nginx/includes.d/mage-two;
	  }" > /etc/nginx/conf.d/vhosts/default.conf
'

sudo -- sh -c -e "echo '127.0.0.1  $hostName' >> /etc/hosts";


echo DataBase configuration:

read -p 'Database Name?: (default: magento_db ) ' databaseName

if [ "$databaseName" = "" ]
then
  databaseName=${VARIABLE:-magento_db} 
fi

sudo docker exec orange_percona bash -c "mysql -u root -proot -e 'create database $databaseName'"

echo 'created database' $databaseName

sudo docker-compose up --build -d

echo 'Finish'

echo 'magento instalation running at url:' http://$hostName

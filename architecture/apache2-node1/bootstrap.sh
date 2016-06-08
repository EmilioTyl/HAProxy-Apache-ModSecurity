#!/usr/bin/env bash

#Paramenters
MYSQL_ROOT_PASSWORD=''

#Installation
apt-get update

apt-get install -y vim
apt-get install -y curl

#Install Apache Web Server
apt-get install -y apache2

#Install MySQL
DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

apt-get install -y libapache2-mod-auth-mysql php5-mysql

mysql_install_db

apt-get install -y expect

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo "$SECURE_MYSQL"

#Install PHP

apt-get install -y  php5 libapache2-mod-php5 php5-mcrypt

cp /vagrant_data/dir.conf /etc/apache2/mods-enabled/dir.conf

cp /vagrant_data/info.php /var/www/info.php

service apache2 restart

#Install Mod Secucity Module
apt-get install -y libapache2-modsecurity

cp /vagrant_data/modsecurity.conf /etc/modsecurity/
cp /vagrant_data/mod-security.conf /etc/apache2/mods-enabled/

#Enable rules

mkdir -p /usr/share/modsecurity-crs/activated_rules

#SQL Injection rules
ln -s /usr/share/modsecurity-crs/base_rules/modsecurity_crs_41_sql_injection_attacks.conf /usr/share/modsecurity-crs/activated_rules/
ln -s /usr/share/modsecurity-crs/base_rules/modsecurity_41_sql_injection_attacks.data /usr/share/modsecurity-crs/activated_rules/
ln -s ./conf/xss.conf /usr/share/modsecurity-crs/activated_rules/

service apache2 reload


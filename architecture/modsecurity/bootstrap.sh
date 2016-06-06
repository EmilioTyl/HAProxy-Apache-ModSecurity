#!/usr/bin/env bash

#Installation
apt-get update

apt-get install -y vim
apt-get install -y curl

#Install Apache Web Server
apt-get install -y apache2 build-essential apache2-threaded-dev
make
make install

#Configure Apache as a reverse proxy
yes | cp -rf /vagrant_data/httpd.conf /etc/apache2/

cp /vagrant_data/mod_rpaf.conf /etc/apache2/conf.d/  

#Install ModSecurity Module
apt-get install -y libapache2-modsecurity

#Configure ModSecurity
cp /vagrant_data/modsecurity.conf /etc/modsecurity/
cp /vagrant_data/mod-security.conf /etc/apache2/mods-enabled/

#Enable rules
mkdir -p /usr/share/modsecurity-crs/activated_rules

sh /vagrant_data/rules_installer/sql_injection_example.sh

service apache2 reload


#!/usr/bin/env bash

#Installation
apt-get update

apt-get install -y vim
apt-get install -y curl

#Install Apache Web Server
apt-get install -y apache2 

apt-get install libapache2-mod-rpaf

#Configure Apache as a reverse proxy
yes | cp -rf /vagrant_data/httpd.conf /etc/apache2/

cp /vagrant_data/mod_rpaf.conf /etc/apache2/conf.d/ 

#Install apache proxy modules
a2enmod proxy
a2enmod proxy_http

#Add proxy configuration
yes | cp -rf /vagrant_data/httpd.conf /etc/apache2/

#Install ModSecurity Module
apt-get install -y libapache2-modsecurity

#Configure ModSecurity
cp /vagrant_data/modsecurity.conf /etc/modsecurity/
cp /vagrant_data/mod-security.conf /etc/apache2/mods-enabled/

#Enable rules
mkdir -p /usr/share/modsecurity-crs/activated_rules

#WAF Health Check
yes | cp -rf /vagrant_data/rules/aloha.conf /usr/share/modsecurity-crs/activated_rules/

#SQL Injection rules
ln -fs /usr/share/modsecurity-crs/base_rules/modsecurity_crs_41_sql_injection_attacks.conf /usr/share/modsecurity-crs/activated_rules/
ln -fs /usr/share/modsecurity-crs/base_rules/modsecurity_41_sql_injection_attacks.data /usr/share/modsecurity-crs/activated_rules/

#XSS rules
yes | cp -rf /vagrant_data/rules/xss.conf /usr/share/modsecurity-crs/activated_rules/
perl /vagrant_data/remove-2.7-actions.pl -t 2.6 -f /usr/share/modsecurity-crs/activated_rules/xss.conf

service apache2 reload


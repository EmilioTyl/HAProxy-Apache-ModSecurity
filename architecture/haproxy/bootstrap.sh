#!/usr/bin/env bash

apt-get update

apt-get install -y curl
apt-get install -y vim

#Add a repository with the lastest version of haproxy
apt-get install -y python-software-properties
add-apt-repository -y ppa:vbernat/haproxy-1.6

apt-get update

#Install haproxy
apt-get install -y haproxy

#Enable haproxy to be started when the machine starts
yes | cp -rf /vagrant_data/haproxy /etc/default/haproxy

#Enable the new configuration for haproxy
yes | cp -rf /vagrant_data/haproxy.cfg /etc/haproxy/

#Configure HAProxy logs
yes | cp -rf /vagrant_data/49-haproxy.conf /etc/rsyslog.d/

#Restart the System's logs server
restart rsyslog

#Restart haproxy
service haproxy restart


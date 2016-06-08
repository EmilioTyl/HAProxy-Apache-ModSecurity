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
cp /vagrant_data/haproxy /etc/default/haproxy

#Disable the original configuration of haproxy
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original

#Enable the new configuration for haproxy
cp /vagrant_data/haproxy.cfg /etc/haproxy/haproxy.cfg

#Configure HAProxy logs
yes | cp -rf /vagrant_data/49-haproxy.conf /etc/rsyslog.d/

#Restart the System's logs server
restart rsyslog

#Restart haproxy
service haproxy reload


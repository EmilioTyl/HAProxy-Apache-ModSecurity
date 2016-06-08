#!/usr/bin/env bash

apt-get update

apt-get install -y python-software-properties
add-apt-repository -y ppa:vbernat/haproxy-1.6

apt-get update

apt-get install -y curl
apt-get install -y vim
apt-get install -y haproxy

cp /vagrant_data/haproxy /etc/default/haproxy
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original
cp /vagrant_data/haproxy.cfg /etc/haproxy/haproxy.cfg

#Configure HAProxy logs

yes | cp -rf /vagrant_data/49-haproxy.conf /etc/rsyslog.d/

restart rsyslog

service haproxy reload


#!/usr/bin/env bash

apt-get update
apt-get install -y curl
apt-get install -y vim
apt-get install -y haproxy

cp /vagrant_data/haproxy /etc/default/haproxy
mv /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.original
cp /vagrant_data/haproxy.cfg /etc/haproxy/haproxy.cfg


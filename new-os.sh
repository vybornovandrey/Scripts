#!/bin/bash
echo "*******************************"
echo "*  Begin update new CentOS 7  *"
echo "*******************************"
sleep 5
yum install -y epel-release
yum -y update
yum install -y vim nano net-tools yum-utils bind-utils iftop htop wget bzip2 traceroute gdisk tmux tree screen
echo "*******************************"
echo "*      Disable Firewall       *"
echo "*******************************"
sleep 5
systemctl stop firewalld
systemctl disable firewalld
sleep 5
useradd -p sonechka77 andrey
usermod -aG wheel andrey

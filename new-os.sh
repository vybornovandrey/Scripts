#!/bin/bash
echo "*******************************"
echo "*  Begin update new CentOS 7  *"
echo "*******************************"

yum install -y epel-release
yum update -y
yum install -y \
    ansible \
    atop \
    bind-utils \
    bzip2 \
    gdisk \
    git \
    htop \
    iftop \
    nano \
    net-tools \
    screen \
    tcpdump \
    tmux \
    traceroute \
    tree \
    vim \
    wget \
    yum-plugin-remove-with-leaves \
    yum-utils

#Добавляем пользователя
useradd andrey
echo "andrey:$1" | chpasswd
usermod -aG wheel andrey

mkdir /home/andrey/.ssh && chown andrey:andrey /home/andrey/.ssh && chmod 700 /home/andrey/.ssh
touch /home/andrey/.ssh/authorized_keys && chown andrey:andrey /home/andrey/.ssh/authorized_keys && chmod 600 /home/andrey/.ssh/authorized_keys

# add ssh key for user andrey
cat > /home/andrey/.ssh/authorized_keys <<EOF
---- BEGIN SSH2 PUBLIC KEY ----
Comment: "hp-probook"
AAAAB3NzaC1yc2EAAAABJQAAAQEAtxQKUzK5zdE29WgZs7aH01ZRq/Pt58jiqxr5
iUbWxor1G1tB03FcNs+2JNuiIE8aAhkyJs0SKiOqvB0rzMRqz+Ors/pZ8VMwOkTA
9aKnp/JHXJ3squ1DgXyyjFeR3WxIPAIB5EEYGWGf6OR7Mj+/Vi86ao6Ejw21pSdg
3VmE4LdH1J28DZ4IBxwxVp4Dgajijnzguo3DtwjEPM1J7LJMfzkB2+PbMDpETxJa
7vDyyd3nsmsoxqSEMOs0kIjFvlR1tNaIxUg7+c23UhDjrp1YYp0mFGmJeSv9d4P+
24xQRHEZaGqYXvZti05lZtIsF8qY6I7ACLwYLFAXm4pZmi5Pxw==
---- END SSH2 PUBLIC KEY ----
EOF

#Настраиваем (отключаем) firewall
echo "*******************************"
echo "*      Disable Firewall       *"
echo "*******************************"
sleep 5
systemctl stop firewalld
systemctl disable firewalld

#Отключаем SElinux
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

echo "*******************************"
echo "*      SElinux disabled       *"
echo "*******************************"

#!/bin/bash
echo "*******************************"
echo "*  Begin update new CentOS 7  *"
echo "*******************************"

yum install -y epel-release
yum update -y
yum install -y \
    atop \
    bind-utils \
    bzip2 \
    gdisk \
    htop \
    iftop \
    nano \
    net-tools \
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
usermod -aG wheel andrey

mkdir /home/andrey/.ssh && chown andrey:andrey /home/andrey/.ssh && chmod 700 /home/andrey/.ssh
touch /home/andrey/.ssh/authorized_keys && chown andrey:andrey /home/andrey/.ssh/authorized_keys && chmod 600 /home/andrey/.ssh/authorized_keys

# add ssh key for user andrey
cat > /home/andrey/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAyH4Ozx/OsK7lxLv+HQnX9Kh2inorKlUCTe8oXia+SCQHIHMnLKgydSjY/wLUDhTHPiSwX9WLXQYIRMRSCOq5ThOvRBNhXqXTEsAarYiYrtqt5YhiwVGZtLA7ZpR/g6tu07cqJY7SBwH1QkIP3wN8zWjdM9UjqdacA/13hVRRn/Li2P9BaWAG8FkfAf75j83WPL803plaMYWbDO54t/eLl7qLMdaKkmPx+IH7wOSjhlkzdt2LjDUbi2VWC9Xptvv47gABteXlrOXalZzVGsY8m9vkMJPQXTfaD9C6I5cvif7J/vYKmV8OKFgW/SSXbFGZoD1vLExwqaMC07MW3+yvxQ== anvy0321@WS-14493
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

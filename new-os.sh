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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDR8xn8u0wWiZLZOc1wN18Ez8OwT9ajqCNgaqZLTAOyWGi8wuejdVPpFbF+gIceC8wcL3MNDjQShYX/Pyufj7vowNgc2/i2qRdE3vJ/WgDLLxIyDjOEIZ9vTzMbsHSMLKQ8vR+//Y7J+No9b++A3p76iqg6PpMmOEprW0UOA4v3mwzZDipSsRAVM20koYl2w7Z9MJWihpXQiEaMi4n7uAkWi/g/SrA7VgrvgJ8d+GQODixrM3APTCNtMm2KKOoSJvPYYIbfaAUWo5rANhA3hLiI65jDWAUXovT0tbwxnLm0bCga8M3GC9yHSc4CMQOkjbZrphJL0V7Guf1xlHv/I/L/+720dXHlqIyZCz2L/N95HGmeKxwZuvtZ1Gcz3VCaYKWxoEYvhIWQv89w5TVswn/Gy4UiswDHId1kwNinSNZU5/v3vkClZhJ0SAjEBVCifCiXtKY7gmLZ26VCuL6KozABLQabpqXrkU5J1CjVWiL8IXbhLBOPhRsas1VEqBOIQYE= andrey@Tronheim
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
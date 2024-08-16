#!/bin/bash -e

rootpw="MyPassword@@"

cat /etc/ssh/sshd_config | sed "s/PasswordAuthentication no/PasswordAuthentication yes/" | sed "s/#PermitRootLogin yes/PermitRootLogin yes/" > /etc/ssh/sshd_config
echo "
MaxAuthTries 10" >> /etc/ssh/sshd_config
systemctl restart sshd

echo root:$rootpw | chpasswd

apt install cron-apt nano -y
cat /etc/apt/cron-apt.conf | sed "s/apply_updates = no/apply_updates = yes/" > /etc/apt/cron-apt.conf
systemctl restart cron-apt

echo "SELINUX=permissive
SELINUXTYPE=targeted" > /etc/selinux/config
setenforce permissive

#!/bin/bash

host_name="PonyCool"
ip_addr="10.129.37.114"

#关闭selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

#设置hostname
hostnamectl --static set-hostname $host_name

sed -i "/^$ip_addr/d" /etc/hosts
echo "$ip_addr $host_name" >> /etc/hosts

sed -i "/^HOSTNAME/d" /etc/sysconfig/network
echo "HOSTNAME=$host_name" >> /etc/sysconfig/network

hostname -f

yum install -y curl

#安装Docker

yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker

#配置镜像加速器
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://onkbrpp6.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker

#安装pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

#安装docker-compose
pip install docker-compose
docker-compose -v

#重启
reboot
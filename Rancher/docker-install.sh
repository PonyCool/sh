#!/bin/bash

# 修改系统源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# Docker-ce安装
# 因为CentOS的安全限制，通过RKE安装K8S集群时候无法使用root账户。所以，建议CentOS用户使用非root用户来运行docker

# 添加用户(可选)
# sudo adduser rancher
# 为新用户设置密码
# sudo passwd rancher
# 为新用户添加sudo权限
# sudo echo 'rancher ALL=(ALL) ALL' >> /etc/sudoers
# 卸载旧版本Docker软件
sudo yum remove docker \
              docker-client \
              docker-client-latest \
              docker-common \
              docker-latest \
              docker-latest-logrotate \
              docker-logrotate \
              docker-selinux \
              docker-engine-selinux \
              docker-engine \
              container*
# 定义安装版本
export docker_version=17.03.2
# step 1: 安装必要的一些系统工具
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 bash-completion
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
sudo yum makecache all
version=$(yum list docker-ce.x86_64 --showduplicates | sort -r|grep ${docker_version}|awk '{print $2}')
sudo yum -y install --setopt=obsoletes=0 docker-ce-${version} docker-ce-selinux-${version}
# 如果已经安装高版本Docker,可进行降级安装(可选)
yum downgrade --setopt=obsoletes=0 -y docker-ce-${version} docker-ce-selinux-${version}
# 把当前用户加入docker组
# sudo usermod -aG docker rancher
# 设置开机启动
sudo systemctl enable docker
sudo systemctl start docker
# Docker配置
cp daemon.json /etc/docker/daemon.json

# 重启
reboot
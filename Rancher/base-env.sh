#!/bin/bash
# rancher 容器管理平台主节点基础环境配置
# Centos/RedHat Linux 7.5+(64位)

# 修改主机名
host_name="k8s-master-1"  # 本节点主机名，此处根据实际情况进行修改
ip_addr="10.31.49.179"   # 本节点IP

hostnamectl --static set-hostname $host_name

sed -i "/^$ip_addr/d" /etc/hosts
echo "$ip_addr $host_name" >> /etc/hosts

sed -i "/^HOSTNAME/d" /etc/sysconfig/network
echo "HOSTNAME=$host_name" >> /etc/sysconfig/network

hostname -f

# 关闭 selinux
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# 关闭防火墙
systemctl stop firewalld.service && systemctl disable firewalld.service

# 配置主机时间、时区、系统语言
# 修改时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 查看时区
date -R
# 修改系统语言环境
sudo echo 'LANG="en_US.UTF-8"' >> /etc/profile;source /etc/profile

# Kernel性能调优
cat >> /etc/sysctl.conf<<EOF
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-iptables=1
net.ipv4.neigh.default.gc_thresh1=4096
net.ipv4.neigh.default.gc_thresh2=6144
net.ipv4.neigh.default.gc_thresh3=8192
EOF
sysctl -p

#重启
reboot
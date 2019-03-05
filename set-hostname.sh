#!/bin/bash

host_name="k8s-master1"
ip_addr="10.66.159.140"

#关闭selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

#设置hostname
hostnamectl --static set-hostname $host_name

sed -i "/^$ip_addr/d" /etc/hosts
echo "$ip_addr $host_name" >> /etc/hosts

sed -i "/^HOSTNAME/d" /etc/sysconfig/network
echo "HOSTNAME=$host_name" >> /etc/sysconfig/network

hostname -f

reboot
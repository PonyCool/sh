#!/bin/bash
# 阿里云服务器ECS普通云盘挂载脚本

yum install -y tar
cd ~
wget http://oss.aliyuncs.com/aliyunecs/auto_fdisk.tgz
tar -zxvf auto_fdisk.tgz
bash auto_fdisk.sh
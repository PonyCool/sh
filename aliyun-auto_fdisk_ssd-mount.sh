#!/bin/bash
# 阿里云服务器ECS SSD云盘挂载脚本

yum install -y unzip
cd ~
wget http://aliyun_portal_storage.oss-cn-hangzhou.aliyuncs.com/help%2Fecs%2Fauto_fdisk_ssd.zip
unzip help%2Fecs%2Fauto_fdisk_ssd.zip
bash auto_fdisk_ssd.sh

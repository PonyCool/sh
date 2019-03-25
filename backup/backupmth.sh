#!/bin/bash
#==========================================
#每月备份代码文件
#到/mnt/project/backup/data
#==========================================

#备份目录
basedir=/mnt/project/backup/data

PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C

basefile=$basedir/code-$(date +%Y-%m-%d).tar.bz2
[ ! -d "$basedir" ] && mkdir $basedir

#压缩文件到指定目录
cd /mnt/project
  tar -jpc -f $basefile code
#! /bin/bash

# --conf-path 指定配置文件路径
# --enable-rpc 启用rpc
# -D 后台运行
aria2c --conf-path="/etc/aria2/aria2.conf" --enable-rpc --rpc-listen-all -D
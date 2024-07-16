#!/bin/bash
ports=$(sudo ovs-vsctl list port | grep name | awk -F '"' '{print $2}')

for port in $ports; do
    # 删除端口的 QoS 设置
    sudo ovs-vsctl clear port $port qos
    echo "已清除端口 $port 的 QoS 设置"
done

#!/bin/bash
# 创建 QoS 策略并获取其 ID
qos_id=$(sudo ovs-vsctl -- --id=@qos create qos type=linux-htb other-config:max-rate=200000000 queues=0=@q0 -- --id=@q0 create queue other-config:min-rate=200000000 other-config:max-rate=200000000 |& grep -o '[0-9a-f-]\+' | head -n 1)

if [ -z "$qos_id" ]; then
    echo "创建 QoS 策略失败，请检查命令和网络环境。"
    exit 1
fi

echo "成功创建 QoS 策略，ID: $qos_id"

# 获取所有端口
ports=$(sudo ovs-vsctl list port | grep name | awk -F '"' '{print $2}')

# 应用 QoS 策略到每个端口
for port in $ports; do
    sudo ovs-vsctl set port $port qos=$qos_id
    if [ $? -eq 0 ]; then
        echo "已将 QoS 策略应用到端口 $port"
    else
        echo "应用 QoS 策略到端口 $port 失败"
    fi
done

echo "完成所有端口的 QoS 策略应用"


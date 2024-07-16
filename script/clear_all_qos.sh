#!/bin/bash
# 清除所有 QoS 策略
sudo ovs-vsctl --all destroy qos

# 输出清除完成的信息
echo "所有 QoS 策略已被清除。"

#!/bin/bash
# 创建对应的h2容器
docker run -d --privileged --net=none --name h2 quay.io/frrouting/frr:10.0.0
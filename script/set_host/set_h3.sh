#!/bin/bash
# 创建对应的h3容器
docker run -d --privileged --net=none --name h3 quay.io/frrouting/frr:10.0.0
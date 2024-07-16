#!/bin/bash
# 首先创建对应的h1容器
docker run -d --privileged --name h1 quay.io/frrouting/frr:10.0.0
REPO_FILE="/etc/apk/repositories"

# 替换主仓库地址
docker exec -i h1 sed -i 's|https://dl-cdn.alpinelinux.org/alpine/v3.19/main|https://mirrors.aliyun.com/alpine/v3.19/main|g' $REPO_FILE

# 替换社区仓库地址
docker exec -i h1 sed -i 's|https://dl-cdn.alpinelinux.org/alpine/v3.19/community|https://mirrors.aliyun.com/alpine/v3.19/community|g' $REPO_FILE

docker exec -i h1 echo "Alpine Linux repositories 已更新."
#更新apk源
docker exec -i h1 apk update
#下载iperf
docker exec -i h1 apk add iperf
# 清除默认路由网关
# 查找当前默认网关的 IP 地址
GATEWAY=$(docker exec -i h1 ip route show default | grep default | awk '{print $3}')

# 检查是否找到默认网关
if [ -z "$GATEWAY" ]; then
  echo "没有找到默认网关，无法删除。"
  exit 1
fi

# 删除默认网关
docker exec -i h1 ip route del default via $GATEWAY

# 输出删除的网关信息
echo "默认网关 $GATEWAY 已被删除。"
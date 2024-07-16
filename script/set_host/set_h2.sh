# 创建对应的h2容器
docker run -d --privileged --net=none --name h2 quay.io/frrouting/frr:10.0.0
# 设置网关
docker exec -i h2 route add default gw 10.2.2.20
# 创建对应的h3容器
docker run -d --privileged --net=none --name h3 quay.io/frrouting/frr:10.0.0
# 设置网关
docker exec -i h3 route add default gw 10.3.3.30
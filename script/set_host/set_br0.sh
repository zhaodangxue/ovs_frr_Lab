#!/bin/bash
# Define bridge name
bridge="br0"

# Define container details in multiple arrays
containers=("h1" "h2" "h3" "h4")
interfaces=("eth1" "eth2")

# IP addresses for each container's interfaces
declare -A ip_addresses=(
    ["h1"]="10.1.1.100/24 10.1.2.100/24"
    ["h2"]="10.2.2.100/24 10.2.3.100/24"
    ["h3"]="10.3.3.100/24 10.3.4.100/24"
    ["h4"]="10.4.4.100/24 10.4.1.100/24"
)

# Loop through each container, interface, and IP address to execute ovs-docker commands
for container in "${containers[@]}"; do
    for index in "${!interfaces[@]}"; do
        interface="${interfaces[$index]}"
        ip_address="${ip_addresses[$container]}"
        ip_address=$(echo $ip_address | cut -d ' ' -f $((index+1)))

        ovs-docker add-port $bridge $interface $container --ipaddress=$ip_address
    done
done

echo "Network configuration completed successfully."
# 加入新的网关
docker exec -i h1 route add default gw 10.1.1.10
# 设置网关
docker exec -i h2 route add default gw 10.2.2.20
# 设置网关
docker exec -i h3 route add default gw 10.3.3.30
# 加入新的网关
docker exec -i h4 route add default gw 10.4.4.40

echo "Gateway configuration completed successfully."
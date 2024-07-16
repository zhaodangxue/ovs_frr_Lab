#!/bin/bash
# Define bridge name
bridge="br0"

# Define container details in multiple arrays
containers=("frr-01" "frr-02" "frr-03" "frr-04" "frr-05" "frr-06")
interfaces=("eth1" "eth2" "eth3" "eth4")

# IP addresses for each container's interfaces
declare -A ip_addresses=(
    ["frr-01"]="100.1.1.1/30 100.1.2.1/30 100.1.3.1/30 100.1.4.1/30"
    ["frr-02"]="100.2.1.1/30 100.2.2.1/30 100.2.3.1/30 100.2.4.1/30"
    ["frr-03"]="100.1.1.2/30 100.2.1.2/30 10.1.1.10/24 10.4.1.40/24"
    ["frr-04"]="100.1.2.2/30 100.2.2.2/30 10.1.2.10/24 10.2.2.20/24"
    ["frr-05"]="100.1.3.2/30 100.2.3.2/30 10.2.3.20/24 10.3.3.30/24"
    ["frr-06"]="100.1.4.2/30 100.2.4.2/30 10.3.4.30/24 10.4.4.40/24"
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

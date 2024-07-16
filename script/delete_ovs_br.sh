#!/bin/bash
# Define bridge name
bridge="br0"

# Define container details in multiple arrays
containers=("frr-01" "frr-02" "frr-03" "frr-04" "frr-05" "frr-06")
interfaces=("eth1" "eth2" "eth3" "eth4")

# Loop through each container and interface to delete ports
for container in "${containers[@]}"; do
    for interface in "${interfaces[@]}"; do
        ovs-docker del-port $bridge $interface $container
    done
done

echo "Port deletion completed successfully."
#delete br br0
ovs-vsctl del-br br0
#verify br0 deleted
ovs-vsctl show

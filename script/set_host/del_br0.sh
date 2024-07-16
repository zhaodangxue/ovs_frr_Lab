# Define bridge name
bridge="br0"

# Define container details in multiple arrays
containers=("h1" "h2" "h3" "h4")
interfaces=("eth1" "eth2")

# Loop through each container and interface to delete ports
for container in "${containers[@]}"; do
    for interface in "${interfaces[@]}"; do
        ovs-docker del-port $bridge $interface $container
    done
done

echo "Port deletion completed successfully."
#!/bin/bash
# Containers array
containers=("frr-01" "frr-02" "frr-03" "frr-04" "frr-05" "frr-06")

# Loop through each container
for container in "${containers[@]}"
do
  echo "Updating configuration in container: $container"
  docker exec $container sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
  docker exec $container /etc/init.d/frr restart
done

echo "Restarted FRR daemon in all containers."

# Start all containers
for container in "${containers[@]}"
do
  docker start $container
done

echo "All containers are started."

#!/bin/bash
# Pull the Docker image
docker pull quay.io/frrouting/frr:10.0.0

# Run 6 Docker containers with sequential names
for ((i=1; i<=6; i++))
do
  docker run -d --privileged --net=none --name frr-0$i quay.io/frrouting/frr:10.0.0
done

echo "All containers are up and running."
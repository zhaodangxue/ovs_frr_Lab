# Pull the Docker image
docker pull quay.io/frrouting/frr:10.0.0

# Run 6 Docker containers with the specified names
for i in {1..6}
do
  docker run -d --privileged --net=none --name frr-0$i quay.io/frrouting/frr:10.0.0
done

echo "All containers are up and running."

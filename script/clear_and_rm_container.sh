for i in {1..6}
do
  docker stop frr-0$i
  docker rm frr-0$i
done

echo "All specified containers have been stopped and removed."

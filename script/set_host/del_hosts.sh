#!/bin/bash
for i in {1..4}
do
  docker stop h$i
  docker rm h$i
done

echo "All specified containers have been stopped and removed."
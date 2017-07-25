containerId=$(docker ps -q | tail -n 1)

docker stop $containerId
docker rm $containerId

containerId=$(docker ps -q | xargs docker inspect --format="{{.Name}}" $1 | grep -v "hoegg-site" | tail -n 1)

if [[ $containerId != "" ]]; then
	docker stop $containerId
	docker rm $containerId
fi

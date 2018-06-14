#!/bin/bash

# $2 => name of container you want to keep
containerId=$(docker ps -q | xargs docker inspect --format="{{.Name}}" $1 | grep -v "$2" | tail -n 1)

if [[ $containerId != "" ]]; then
	docker stop $containerId
	docker rm $containerId
fi

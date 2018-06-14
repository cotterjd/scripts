#!/bin/bash

# $1 => docker image
# $2 => name to filter out 

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

dockerImage='254439280817.dkr.ecr.us-east-1.amazonaws.com/hoegg_website_prs:latest'
if [[ $(docker ps | wc -l) < 3 ]]; then #no pr containers running
	port=8081
else
	let port=$(docker ps -q | xargs docker inspect --format="{{.Name}}" $1 | grep -v "$2" | rev | cut -c-4 | rev | xargs echo $1 | cut -c-4)+1
fi

echo $port

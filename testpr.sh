#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

dockerImage='254439280817.dkr.ecr.us-east-1.amazonaws.com/hoegg_website_prs:latest'
if [[ $(docker ps | wc -l) < 3 ]]; then #no pr containers running
	port=8081
else
	let port=$(docker ps -q | xargs docker inspect --format="{{.Name}}" $1 | grep -v "hoegg-site" | rev | cut -c-4 | rev | xargs echo $1 | cut -c-4)+1
fi

echo $port
#$(/root/.local/bin/aws ecr get-login) 
#trigger=$(docker pull $dockerImage | tail -n 1)
##echo $(TZ=America/Chicago date) $trigger $port >> /root/debug.log
#if [[ $trigger == *"Downloaded newer image"* ]]; then  
#	docker run -p $port:3000 --name hoegg-pr$port -d $dockerImage	
#	bash /root/scripts/slackbot.sh "#web-site" "new pr. View at http://162.243.54.40:$port"
#	#bash /root/scripts/testslackbot.sh "#web-site" "new pr. View at http://162.243.54.40:$port"
#	bash /root/scripts/testRoutes.sh http://162.243.54.40:$port
#fi

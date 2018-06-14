#!/bin/bash

dockerImage=$1
containerName=$2

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
$(/root/.local/bin/aws ecr get-login) 
trigger=$(docker pull $dockerImage | tail -n 1) 

echo $(TZ=America/Chicago date) $trigger >> /root/debug.log
if [[ $trigger == *"Downloaded newer image"* ]]; then 
	docker stop $containerName
	docker rm $containerName
	docker run -p 8080:3000 --name $containerName -d $dockerImage 
	
	echo "site updated" $(TZ=America/Chicago date) >> /root/updates.log
	bash /root/scripts/slackbot.sh "#web-site" "website has been updated!"

fi

#bash testRoutes.sh http://www.hoegg.software


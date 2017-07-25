#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
dockerImage='254439280817.dkr.ecr.us-east-1.amazonaws.com/hoegg_software_website:latest'
$(/root/.local/bin/aws ecr get-login) 
trigger=$(docker pull $dockerImage | tail -n 1) 

echo $(TZ=America/Chicago date) $trigger >> /root/debug.log
if [[ $trigger == *"Downloaded newer image"* ]]; then 
	docker stop hoegg-site 
	docker rm hoegg-site
	docker run -p 8080:3000 --name hoegg-site -d $dockerImage 
	
	echo "site updated" $(TZ=America/Chicago date) >> /root/updates.log
	bash /root/scripts/slackbot.sh "#web-site" "hoegg.software has been updated!"
	#bash testslackbot.sh "#web-site" "webserver-bot" "hoegg.software has been updated!"

fi

#bash testRoutes.sh http://www.hoegg.software


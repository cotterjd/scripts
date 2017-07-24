#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
dockerImage='254439280817.dkr.ecr.us-east-1.amazonaws.com/hoegg_software_website:latest'
$(/root/.local/bin/aws ecr get-login) 
trigger=$(docker pull $dockerImage | tail -n 1) 

if [[ $trigger == *"Downloaded newer image"* ]]; then 
	docker stop hoegg-site 
	docker rm hoegg-site
	docker run -p 8080:3000 --name hoegg-site -d $dockerImage 
	
	echo "site updated" $(date "+%m-%d-%Y %H:%M") "Server time" >> /root/updates.log
	sh slackpost.sh "https://hooks.slack.com/services/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" "#web-site" "webserver-bot" "hoegg.software has been updated!"
	#bash testslackbot.sh "#web-site" "webserver-bot" "hoegg.software has been updated!"

fi

bash testRoutes.sh http://www.hoegg.software


#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
$(/root/.local/bin/aws ecr get-login) 

docker stop hoegg-site 
docker rm hoegg-site
docker run -p 8080:3000 --name hoegg-site -d 254439280817.dkr.ecr.us-east-1.amazonaws.com/hoegg_software_website:latest 
	


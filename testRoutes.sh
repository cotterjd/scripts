#!/bin/bash

uri=$1
if [[ $uri == "" ]]; then
	echo "no url given"
	exit 1
fi

checkRoute() {
	url=$1/$2
	if [ $(curl -so /dev/null -Iw "%{http_code}" $url) == 404 ]; then
		sh testslackbot.sh "#web-site" $url " is returning a 404!"
	fi 
}

checkRoute $uri ""
checkRoute $uri "about_us" 
checkRoute $uri "what_we_offer"
checkRoute $uri "careers"
checkRoute $uri "blog"
checkRoute $uri "dora"
checkRoute $uri "apply"
checkRoute $uri "contact"
checkRoute $uri "foo"

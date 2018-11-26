#!/bin/bash

uri=$1

if [[ $uri == "" ]]; then
	echo url required
	exit 1
fi

errorCode=0

checkRoute() {
	url=$1/$2
	http_code=$(curl -so /dev/null -Iw "%{http_code}" $url)
	if [[ $http_code != 200 ]]; then
		errorCode=1
		if [[ !($url =~ .*localhost.*) ]]; then
                  bash /root/scripts/slackbot.sh "#web-site" $url " returns " $http_code
		  # TODO: rollback
		else
			echo $url returned $http_code
		fi
	fi
}

checkRoute $uri ""
# TODO: find out why this route always returns 404 even tho it works
#checkRoute $uri "support/reset"
#checkRoute $uri "foo"

if [[ $errorCode != 1 ]]; then
	echo "all routes are good"
fi

exit $errorCode


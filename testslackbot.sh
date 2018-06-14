#!/bin/bash

hook=$1

shift
text=$*

if [[ $text == "" ]]
then
        echo "No message specified"
        exit 1
fi

escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )

json="{\"channel\": \"\", \"username\":\"webserver-bot\", \"icon_emoji\":\":airplane_departure:\", \"text\": \"$escapedText\"}"

curl -s -d "payload=$json" "$hook"

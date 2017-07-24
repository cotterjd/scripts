#!/bin/bash

channel=$1

if [[ $channel == "" ]]
then
        echo "No channel specified"
        exit 1
fi

shift
text=$*

if [[ $text == "" ]]
then
        echo "No message specified"
        exit 1
fi

escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )

json="{\"channel\": \"$channel\", \"username\":\"webserver-bot\", \"icon_emoji\":\":airplane_departure:\", \"text\": \"$escapedText\"}"

curl -s -d "payload=$json" "https://hooks.slack.com/services/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"

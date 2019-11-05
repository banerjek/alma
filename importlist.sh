#!/bin/bash
xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/conf/md-import-profiles")
echo $xmldoc |xmlstarlet fo 

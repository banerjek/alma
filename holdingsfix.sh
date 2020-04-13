#!/bin/bash

cat serials.csv | while read item
do
	# separate into fields
	mms_id="$(cut -d',' -f1 <<<$item)"
	holding_id="$(cut -d',' -f2 <<<$item)"
	item_pid="$(cut -d',' -f3 <<<$item)"
	call_num="$(cut -d',' -f4 <<<$item)"
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}"
	# Retrieves item, holding, and bib data
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET $getstring)
	#xmldoc=$(echo $xmldoc | sed "s#<subfield code="h">[^<]*</subfield>#<subfield code="h">$call_num</subfield>#")
	echo $xmldoc |fgrep PCOUNT > /dev/null && echo "bad 852 detected"
	echo $xmldoc |fgrep PCOUNT > /dev/null && echo "$mms_id $holding_id" >> 852_repaired
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d '/holding/record/datafield[@tag="852"][subfield[@code="x"][contains(text(), "PCOUNT")]]')
	#xmldoc=$(echo $xmldoc | xmlstarlet ed -u "/holding/record/datafield[@tag='852']/subfield[@code='h']" -v "$call_num")
	# fix material type and in_temp location if broken
	#xmldoc=$(echo $xmldoc |sed 's#<physical_material_type>ELEC</physical_material_type>#<physical_material_type>OTHER</physical_material_type>#')	
	# check to make sure it worked
	updatedoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -X PUT --data "${xmldoc}" $getstring)
	echo $updatedoc |grep -v PCOUNT > /dev/null && echo "852s are good for $mms_id $holding_id"
	echo "$mms_id,$holding_id" >> completed
done

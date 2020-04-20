#!/bin/bash

cat 852_no_sub_h.csv | while read item
do
	# separate into fields
	item=$(sed 's/[^0-9,]//g' <<< $item)
	mms_id="$(cut -d',' -f1 <<<$item)"
	holding_id="$(cut -d',' -f2 <<<$item)"
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}"
	# Retrieves item, holding, and bib data
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET $getstring)
	date008=$(date "+%y%m%d")
	#edit only 852s that don't contain $h
	xmldoc=$(echo $xmldoc | xmlstarlet ed -u '/holding/record/datafield[@tag="852"][not(subfield[@code="h"])]/@ind1' -v '5')

	# fix 008
	# a=yes, b=no, u=unknown
	#lending="a"
	#copying="a"
	#new008=${date008}'0u\\\\0\\\0001'${lending}${copying}'und0999999'
	#xmldoc=$(echo $xmldoc | xmlstarlet ed -u '/holding/record/controlfield[@tag="008"]' -v ${new008})

#	xmldoc=$(echo $xmldoc | xmlstarlet ed -d '/holding/record/datafield[@tag="852"][subfield[@code="x"][contains(text(), "PCOUNT")]]')
	#count852=$(echo $xmldoc | xmlstarlet sel -t -m '/holding/record' -c 'count(datafield[@tag="852"])')
	#echo "$mms_id,$holding_id,$count852" >> count852
	# fix material type and in_temp location if broken
	# check to make sure it worked
	updatedoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -X PUT --data "${xmldoc}" $getstring)
	ind1=$(echo $updatedoc |xmlstarlet sel -t -m '/holding/record/datafield[@tag="852"][not(subfield[@code="h"])]/@ind1')
	echo 'Ind1 has been assigned "'$ind1'" to '$mms_id",$holding_id"
	echo "$mms_id,$holding_id" >> completed
done

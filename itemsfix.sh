#!/bin/bash

cat items.csv | while read item
do
	# separate into fields. A space kept appearing at the beginning, so a bogus field was added
	mms_id="$(cut -d',' -f1 <<<$item)"
	holding_id="$(cut -d',' -f2 <<<$item)"
	item_pid="$(cut -d',' -f3 <<<$item)"
	call_num="$(cut -d',' -f4 <<<$item)"
	#make sure we only match and delte the correct nodes
	match_expression="/item/item_data[public_note='Other call numbers: $call_num']"
	
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}"
	# Retrieves item, holding, and bib data
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET "https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}")
	
	# Extract public note, use character position to remove undesirable parts
	public_note=$(echo $xmldoc | xmlstarlet sel -T -t -m "$match_expression" -v public_note)

	# delete and insert rather than updating to prevent duplicate fields
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "$match_expression")

	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "/item/holding_data/temp_call_number")
	xmldoc=$(echo $xmldoc | xmlstarlet ed -s "/item/holding_data" -t elem -n "temp_call_number" -v "$call_num")
	
	echo $xmldoc |xmlstarlet fo
exit

	# put the record back
	results=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -d "$xmldoc" -X PUT "https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}")

	# check to make sure it worked
	checkdoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET "https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}")
	echo $xmldoc |xmlstarlet fo
	exit
done
exit





#mms_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/bib_data/mms_id" -v . )
#holding_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/holding_data/holding_id" -v . )
#item_pid=$(echo $xmldoc |xmlstarlet sel -t -m "item/item_data/pid" -v . )

#if [${item_pid} -eq '']; then
#	# barcode is bad
#	echo ${barcode} >> badbarcodes
#	else
	# barcode is good	
#	putstring="/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}"
#fi


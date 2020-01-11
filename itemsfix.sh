#!/bin/bash

cat items.csv | while read item
do
	# separate into fields. A space kept appearing at the beginning, so a bogus field was added
	mms_id="$(cut -d',' -f1 <<<$item)"
	holding_id="$(cut -d',' -f2 <<<$item)"
	item_pid="$(cut -d',' -f3 <<<$item)"
	call_num="$(cut -d',' -f4 <<<$item)"
	match_expression="/item/item_data[public_note='Other call numbers: $call_num']"
	
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}"
	# Retrieves item, holding, and bib data
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET "https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}")
	
	# Extract public note, use character position to remove undesirable parts
	public_note=$(echo $xmldoc | xmlstarlet sel -T -t -m "$match_expression" -v public_note)
echo $public_note
echo $xmldoc |xmlstarlet fo
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "$match_expression")
exit
	public_note=$(echo $public_note | cut -c21-)

	# update the temp call number and set the public note to nothing
	xmldoc=$(echo $xmldoc | xmlstarlet edit --update "/item/item_data/temp_call_number" --value "$call_num")
	xmldoc=$(echo $xmldoc | xmlstarlet edit --update "/item/item_data/public_note" --value "")
	
	# build the holding record
	suppress_from_publishing=$(echo $xmldoc | xmlstarlet sel -T -t -m '/item/item_data/public_note' -v '.')
	#echo $xmldoc |xmlstarlet fo

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


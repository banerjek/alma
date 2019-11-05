#!/bin/bash

#clean nonumeric data from barcodes
barcode=$(sed 's/[^0-9]//g' <<< "$1")

#clean nondesirable characters from shelf locations
shelfloc=$(sed 's/[^0-9A-Za-z\-\.]//g' <<< "$2")

xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/items?item_barcode=$barcode")

# update the shelf location
xmldoc=$(echo $xmldoc |xmlstarlet ed -u "/item/item_data/storage_location_id" -v $shelfloc)

mms_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/bib_data/mms_id" -v . )
holding_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/holding_data/holding_id" -v . )
item_pid=$(echo $xmldoc |xmlstarlet sel -t -m "item/item_data/pid" -v . )


#check length of item_pid. If zero length, it's bad
if [ ${#item_pid} -eq 0 ]; then
	# barcode is bad
	echo $barcode >> badbarcodes
	echo "barcode $barcode is bad -- logging to file"
	else
	# barcode is good	
	echo "Updating barcode $barcode with shelf location $shelfloc"
	api_endpoint="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/$mms_id/holdings/$holding_id/items/$item_pid"
	result=$(curl -s -X PUT -L -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -d "${xmldoc}" "$api_endpoint")
fi


#!/bin/bash

#clean nonumeric data from barcodes
barcode=$(sed 's/[^0-9]//g' <<< "$1")

xmldoc=$(curl -s -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/items?item_barcode=${barcode}")

mms_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/bib_data/mms_id" -v . )
holding_id=$(echo $xmldoc |xmlstarlet sel -t -m "item/holding_data/holding_id" -v . )
item_pid=$(echo $xmldoc |xmlstarlet sel -t -m "item/item_data/pid" -v . )

if [${item_pid} -eq '']; then
	# barcode is bad
	echo ${barcode} >> badbarcodes
	else
	# barcode is good	
	putstring="/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}"
fi

echo $xmldoc |xmlstarlet fo

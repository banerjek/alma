#!/bin/bash

cat items.csv | while read item
do
	# separate into fields
	mms_id="$(cut -d',' -f1 <<<$item)"
	holding_id="$(cut -d',' -f2 <<<$item)"
	item_pid="$(cut -d',' -f3 <<<$item)"
	call_num="$(cut -d',' -f4 <<<$item)"

	
	#make sure we only match and delte the correct nodes
	match_expression="/item/item_data[public_note='Other call numbers: $call_num']"
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/bibs/${mms_id}/holdings/${holding_id}/items/${item_pid}"
	# Retrieves item, holding, and bib data
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET $getstring)
	# fix material type and in_temp location if broken
	xmldoc=$(echo $xmldoc |sed 's#<physical_material_type>ELEC</physical_material_type>#<physical_material_type>OTHER</physical_material_type>#')	
	xmldoc=$(echo $xmldoc |sed 's#<in_temp_location>false</in_temp_location>#<in_temp_location>true</in_temp_location>#')	
	# get mat type, location, and library
	library=$(echo $xmldoc | xmlstarlet sel -T -t -m "/item/item_data/library" -v '.')
	location=$(echo $xmldoc | xmlstarlet sel -T -t -m "/item/item_data/location" -v '.')

	# Extract public note, use character position to remove undesirable parts
	public_note=$(echo $xmldoc | xmlstarlet sel -T -t -m "$match_expression" -v public_note)

	# delete and insert rather than updating to prevent duplicate fields
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "$match_expression/public_note")

	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "/item/holding_data/temp_library")
	xmldoc=$(echo $xmldoc | xmlstarlet ed -s "/item/holding_data" -t elem -n "temp_library" -v "$library")
	
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "/item/holding_data/temp_location")
	xmldoc=$(echo $xmldoc | xmlstarlet ed -s "/item/holding_data" -t elem -n "temp_location" -v "$location")
	
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "/item/holding_data/temp_call_number")
	xmldoc=$(echo $xmldoc | xmlstarlet ed -s "/item/holding_data" -t elem -n "temp_call_number" -v "$call_num")
	
	xmldoc=$(echo $xmldoc | xmlstarlet ed -d "/item/holding_data/temp_call_number_type")
	xmldoc=$(echo $xmldoc | xmlstarlet ed -s "/item/holding_data" -t elem -n "temp_call_number_type" -v "8")
	
	# check to make sure it worked
	updatedoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -X PUT --data "${xmldoc}" $getstring)
	temp_location=$(echo $updatedoc | xmlstarlet sel -T -t -m "/item/holding_data/temp_location" -v '.')
	echo "$mms_id,$holding_id,$item_pid $temp_location" >> smccd_fix
done

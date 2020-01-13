#!/bin/bash

	
for user in $(cat users)
do
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/users/${user}?user_id_type=all_unique"
	
	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET $getstring)
	
	email=$(echo $xmldoc | xmlstarlet sel -T -t -m '/user/contact_info/emails/email[@preferred="true"]/email_address' -v '.')
	
	# delete password and force password change
	xmldoc=$(echo $xmldoc |xmlstarlet ed -d /user/password)
	xmldoc=$(echo $xmldoc |xmlstarlet ed -d /user/force_password_change)

	# add email to user identifier
	newnode="<user_identifier><id_type desc='Institution ID'>INST_ID</id_type><value>${email}</value><status>ACTIVE</status></user_identifier>"
	
	xmldoc=${xmldoc/<user_identifiers>/<user_identifiers>$newnode}
	xmldoc=${xmldoc/<user_identifiers\/>/<user_identifiers>$newnode<\/user_identifiers>}
	
	# replace the record

	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -X PUT --data "${xmldoc}" $getstring)
	echo "${user} ${email}" >> processed
done

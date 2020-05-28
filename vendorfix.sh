#!/bin/bash

function get_country_code  {
	# replace start and end country tags to simplify regexes
	xmldoc=$(sed '
	s/<country desc="">/BEGIN_COUNTRY/gi 
	s/<\/country>/<END_COUNTRY/gi 
	s/BEGIN_COUNTRY[^<]*alger[^<]*<END_COUNTRY/BEGIN_COUNTRYDZA<END_COUNTRY/i # Algeria 
	s/BEGIN_COUNTRY[^<]*argent[^<]*<END_COUNTRY/BEGIN_COUNTRYARG<END_COUNTRY/i # Argentina
	s/BEGIN_COUNTRYar<END_COUNTRY/BEGIN_COUNTRYARG<END_COUNTRY/i # Argentina
	s/BEGIN_COUNTRY[^<]*armeni[^<]*<END_COUNTRY/BEGIN_COUNTRYARM<END_COUNTRY/i # Armenia
	s/BEGIN_COUNTRY[^<]*austral[^<]*<END_COUNTRY/BEGIN_COUNTRYAUS<END_COUNTRY/i # Australia
	s/BEGIN_COUNTRYau<END_COUNTRY/BEGIN_COUNTRYAUS<END_COUNTRY/i # Australia
	s/BEGIN_COUNTRYat<END_COUNTRY/BEGIN_COUNTRYAUT<END_COUNTRY/i # Austria
	s/BEGIN_COUNTRY[^<]*baham[^<]*<END_COUNTRY/BEGIN_COUNTRYBHS<END_COUNTRY/i # Bahamas
	s/BEGIN_COUNTRY[^<]*bangla[^<]*<END_COUNTRY/BEGIN_COUNTRYBGD<END_COUNTRY/i # Bangladesh
	s/BEGIN_COUNTRY[^<]*barbados[^<]*<END_COUNTRY/BEGIN_COUNTRYBRB<END_COUNTRY/i # Barbados
	s/BEGIN_COUNTRYbe<END_COUNTRY/BEGIN_COUNTRYBEL<END_COUNTRY/i # Belgium
	s/BEGIN_COUNTRY[^<]*belg[^<]*<END_COUNTRY/BEGIN_COUNTRYBEL<END_COUNTRY/i # Belgium
	s/BEGIN_COUNTRY[^<]*belarus[^<]*<END_COUNTRY/BEGIN_COUNTRYBLR<END_COUNTRY/i # Belarus
	s/BEGIN_COUNTRY[^<]*bermu[^<]*<END_COUNTRY/BEGIN_COUNTRYBMU<END_COUNTRY/i # Bermuda
	s/BEGIN_COUNTRY[^<]*boliv[^<]*<END_COUNTRY/BEGIN_COUNTRYBOL<END_COUNTRY/i # Bolivia
	s/BEGIN_COUNTRY[^<]*botsw[^<]*<END_COUNTRY/BEGIN_COUNTRYBWA<END_COUNTRY/i # Botswana
	s/BEGIN_COUNTRYbr<END_COUNTRY/BEGIN_COUNTRYBRA<END_COUNTRY/i # Brazil
	s/BEGIN_COUNTRYbra[sz]il[^<]*<END_COUNTRY/BEGIN_COUNTRYBRA<END_COUNTRY/i # Brazil
	s/BEGIN_COUNTRY[^<]*brunei[^<]*<END_COUNTRY/BEGIN_COUNTRYBRN<END_COUNTRY/i # Brunei
	s/BEGIN_COUNTRY[^<]*bulgar[^<]*<END_COUNTRY/BEGIN_COUNTRYBGR<END_COUNTRY/i # Bulgaria
	s/BEGIN_COUNTRY<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRYBC<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRYcan\?<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRYcana[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRY[^<]*canada[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRY[^<]*ontario[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRY[^<]*oshawa[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRY[^<]*quebec[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i # Canada
	s/BEGIN_COUNTRYch<END_COUNTRY/BEGIN_COUNTRYCHL<END_COUNTRY/i # Chile
	s/BEGIN_COUNTRY[^<]*chile[^<]*<END_COUNTRY/BEGIN_COUNTRYCHL<END_COUNTRY/i # Chile
	s/BEGIN_COUNTRY[^<]*china[^<]*<END_COUNTRY/BEGIN_COUNTRYCHN<END_COUNTRY/i # China 
	s/BEGIN_COUNTRYcn<END_COUNTRY/BEGIN_COUNTRYCHN<END_COUNTRY/i # China
	s/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i # China 
	s/BEGIN_COUNTRYco<END_COUNTRY/BEGIN_COUNTRYCOL<END_COUNTRY/i # Colombia
	s/BEGIN_COUNTRY[^<]*colomb[^<]*<END_COUNTRY/BEGIN_COUNTRYCOL<END_COUNTRY/i # Colombia
	s/BEGIN_COUNTRYcr<END_COUNTRY/BEGIN_COUNTRYCRI<END_COUNTRY/i # Costa Rica
	s/BEGIN_COUNTRY[^<]*costa ri[^<]*<END_COUNTRY/BEGIN_COUNTRYCRI<END_COUNTRY/i # Costa Rica
	s/BEGIN_COUNTRYhr<END_COUNTRY/BEGIN_COUNTRYHRV<END_COUNTRY/i # Croatia
	s/BEGIN_COUNTRY[^<]*croatia[^<]*<END_COUNTRY/BEGIN_COUNTRYHRV<END_COUNTRY/i # Croatia
	s/BEGIN_COUNTRY[^<]*cuba<END_COUNTRY/BEGIN_COUNTRYCUB<END_COUNTRY/i # Cuba
	s/BEGIN_COUNTRY[^<]*cyprus[^<]*<END_COUNTRY/BEGIN_COUNTRYCYP<END_COUNTRY/i # Cyprus
	s/BEGIN_COUNTRYcz<END_COUNTRY/BEGIN_COUNTRYCZE<END_COUNTRY/i # Czech Republic
	s/BEGIN_COUNTRY[^<]*czech[^<]*<END_COUNTRY/BEGIN_COUNTRYCZE<END_COUNTRY/i # Czech Republic
	s/BEGIN_COUNTRYdk<END_COUNTRY/BEGIN_COUNTRYDNK<END_COUNTRY/i # Denmark
	s/BEGIN_COUNTRYdenm[^<]*<END_COUNTRY/BEGIN_COUNTRYDNK<END_COUNTRY/i # Denmark
	s/BEGIN_COUNTRY[^<]*ecuador[^<]*<END_COUNTRY/BEGIN_COUNTRYECU<END_COUNTRY/i # Ecuador
	s/BEGIN_COUNTRY[^<]*england[^<]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # England
	s/BEGIN_COUNTRYde<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i # Germany
	s/BEGIN_COUNTRYdeutsch[^<]*<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i # Germany
	s/BEGIN_COUNTRY[^<]*german[^<]*<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i # Germany
	s/BEGIN_COUNTRY[^<]*egypt[^<]*<END_COUNTRY/BEGIN_COUNTRYEGY<END_COUNTRY/i # Egypt
	s/BEGIN_COUNTRY[^<]*estonia[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i # Estonia
	s/BEGIN_COUNTRYfi<END_COUNTRY/BEGIN_COUNTRYFIN<END_COUNTRY/i # Finland
	s/BEGIN_COUNTRY[^<]*finland[^<]*<END_COUNTRY/BEGIN_COUNTRYFIN<END_COUNTRY/i # Finland
	s/BEGIN_COUNTRYfr<END_COUNTRY/BEGIN_COUNTRYFRA<END_COUNTRY/i # France
	s/BEGIN_COUNTRY[^<]*france[^<]*<END_COUNTRY/BEGIN_COUNTRYFRA<END_COUNTRY/i # France
	s/BEGIN_COUNTRY[^<]*gambia[^<]*<END_COUNTRY/BEGIN_COUNTRYGMB<END_COUNTRY/i # France
	s/BEGIN_COUNTRY[^<]*georgia[^<]*<END_COUNTRY/BEGIN_COUNTRYGEO<END_COUNTRY/i # Georgia
	s/BEGIN_COUNTRY[^<]*ghana[^<]*<END_COUNTRY/BEGIN_COUNTRYGHA<END_COUNTRY/i # Ghana
	s/BEGIN_COUNTRY[^<]*greece[^<]*<END_COUNTRY/BEGIN_COUNTRYGRC<END_COUNTRY/i # Greece
	s/BEGIN_COUNTRY[^<]*greenla[^<]*<END_COUNTRY/BEGIN_COUNTRYGRN<END_COUNTRY/i # Greenland
	s/BEGIN_COUNTRY[^<]*guam[^<]*<END_COUNTRY/BEGIN_COUNTRYGUM<END_COUNTRY/i # Guam
	s/BEGIN_COUNTRY[^<]*guyana[^<]*<END_COUNTRY/BEGIN_COUNTRYGUY<END_COUNTRY/i # Guyana
	s/BEGIN_COUNTRY[^<]*haiti[^<]*<END_COUNTRY/BEGIN_COUNTRYHTI<END_COUNTRY/i # Haiti
	s/BEGIN_COUNTRY[^<]*hondur[^<]*<END_COUNTRY/BEGIN_COUNTRYHND<END_COUNTRY/i # Honduras
	s/BEGIN_COUNTRY[^<]*hong k[^<]*<END_COUNTRY/BEGIN_COUNTRYHKG<END_COUNTRY/i # Hong Kong
	s/BEGIN_COUNTRYhu<END_COUNTRY/BEGIN_COUNTRYHUN<END_COUNTRY/i # Hungary
	s/BEGIN_COUNTRY[^<]*hungar[^<]*<END_COUNTRY/BEGIN_COUNTRYHUN<END_COUNTRY/i # Hungary
	s/BEGIN_COUNTRY[^<]*iceland[^<]*<END_COUNTRY/BEGIN_COUNTRYISL<END_COUNTRY/i # Iceland
	s/BEGIN_COUNTRY[^<]*indones[^<]*<END_COUNTRY/BEGIN_COUNTRYIDN<END_COUNTRY/i # Indonesia
	s/BEGIN_COUNTRYindia[^<]*<END_COUNTRY/BEGIN_COUNTRYIND<END_COUNTRY/i # India
	s/BEGIN_COUNTRY[^<]*iran[^<]*<END_COUNTRY/BEGIN_COUNTRYIRN<END_COUNTRY/i # Iran
	s/BEGIN_COUNTRY[^<]*ireland[^<]*<END_COUNTRY/BEGIN_COUNTRYIRL<END_COUNTRY/i # Ireland
	s/BEGIN_COUNTRYis<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i # Israel
	s/BEGIN_COUNTRY[^<]*isreal[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i # Israel
	s/BEGIN_COUNTRY[^<]*jerusalem[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i # Israel
	s/BEGIN_COUNTRY[^<]*israel[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i # Israel
	s/BEGIN_COUNTRYit<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i # Italy
	s/BEGIN_COUNTRY[^<]*ital[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i # Italy
	s/BEGIN_COUNTRYjm<END_COUNTRY/BEGIN_COUNTRYJAM<END_COUNTRY/i # Jamaica
	s/BEGIN_COUNTRY[^<]*jamai[^<]*<END_COUNTRY/BEGIN_COUNTRYJAM<END_COUNTRY/i # Jamaica
	s/BEGIN_COUNTRYjo<END_COUNTRY/BEGIN_COUNTRYJOR<END_COUNTRY/i # Jordan
	s/BEGIN_COUNTRY[^<]*jordan[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i # Jordan
	s/BEGIN_COUNTRYke<END_COUNTRY/BEGIN_COUNTRYKEN<END_COUNTRY/i # Kenya
	s/BEGIN_COUNTRY[^<]*kenya[^<]*<END_COUNTRY/BEGIN_COUNTRYKEN<END_COUNTRY/i # Kenya
	s/BEGIN_COUNTRYjp<END_COUNTRY/BEGIN_COUNTRYJPN<END_COUNTRY/i # Japan
	s/BEGIN_COUNTRY[^<]*japan[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i # Japan
	s/BEGIN_COUNTRY[^<]*korea[^<]*<END_COUNTRY/BEGIN_COUNTRYKOR<END_COUNTRY/i # Korea
	s/BEGIN_COUNTRY[^<]*kuwait[^<]*<END_COUNTRY/BEGIN_COUNTRYKWT<END_COUNTRY/i # Kuwait
	s/BEGIN_COUNTRYllv<END_COUNTRY/BEGIN_COUNTRYLVA<END_COUNTRY/i # Latvia
	s/BEGIN_COUNTRY[^<]*latvia[^<]*<END_COUNTRY/BEGIN_COUNTRYLVA<END_COUNTRY/i # Latvia
	s/BEGIN_COUNTRYlb<END_COUNTRY/BEGIN_COUNTRYLBN<END_COUNTRY/i # Lebanon
	s/BEGIN_COUNTRY[^<]*lebanon[^<]*<END_COUNTRY/BEGIN_COUNTRYLBN<END_COUNTRY/i # Lebanon
	s/BEGIN_COUNTRY[^<]*lithuan[^<]*<END_COUNTRY/BEGIN_COUNTRYLTU<END_COUNTRY/i # Lithuania
	s/BEGIN_COUNTRY[^<]*luxemb[^<]*<END_COUNTRY/BEGIN_COUNTRYLUX<END_COUNTRY/i # Luxembourg
	s/BEGIN_COUNTRY[^<]*macedonia[^<]*<END_COUNTRY/BEGIN_COUNTRYMKD<END_COUNTRY/i # Macedonia
	s/BEGIN_COUNTRY[^<]*malas[^<]*<END_COUNTRY/BEGIN_COUNTRYMYS<END_COUNTRY/i # Malta
	s/BEGIN_COUNTRY[^<]*malay[^<]*<END_COUNTRY/BEGIN_COUNTRYMYS<END_COUNTRY/i # Malta
	s/BEGIN_COUNTRY[^<]*malta[^<]*<END_COUNTRY/BEGIN_COUNTRYMLT<END_COUNTRY/i # Malta
	s/BEGIN_COUNTRY[^<]*moroc[^<]*<END_COUNTRY/BEGIN_COUNTRYMAR<END_COUNTRY/i # Morocco
	s/BEGIN_COUNTRYmx<END_COUNTRY/BEGIN_COUNTRYMEX<END_COUNTRY/i # Mexico
	s/BEGIN_COUNTRY[^<]*mexico[^<]*<END_COUNTRY/BEGIN_COUNTRYMEX<END_COUNTRY/i # Mexico
	s/BEGIN_COUNTRYnm<END_COUNTRY/BEGIN_COUNTRYNAM<END_COUNTRY/i # Nambia
	s/BEGIN_COUNTRY[^<]*nambia[^<]*<END_COUNTRY/BEGIN_COUNTRYNAM<END_COUNTRY/i # Nambia
	s/BEGIN_COUNTRYnl<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i # Netherlands
	s/BEGIN_COUNTRY[^<]*nederl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i # Netherlands
	s/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i # Netherlands
	s/BEGIN_COUNTRY[^<]*nepal[^<]*<END_COUNTRY/BEGIN_COUNTRYNPL<END_COUNTRY/i # Nepal
	s/BEGIN_COUNTRY[^<]*caledonia[^<]*<END_COUNTRY/BEGIN_COUNTRYNCL<END_COUNTRY/i # New Calendonia
	s/BEGIN_COUNTRYnz<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i # New Zealand
	s/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i # New Zealand
	s/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i # New Zealand
	s/BEGIN_COUNTRY[^<]*aotearoa[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i # New Zealand
	s/BEGIN_COUNTRY[^<]*nigeria[^<]*<END_COUNTRY/BEGIN_COUNTRYNGA<END_COUNTRY/i # Nigeria
	s/BEGIN_COUNTRYno<END_COUNTRY/BEGIN_COUNTRYNOR<END_COUNTRY/i # Norway
	s/BEGIN_COUNTRY[^<]*pakist[^<]*<END_COUNTRY/BEGIN_COUNTRYPAK<END_COUNTRY/i # Pakistan
	s/BEGIN_COUNTRY[^<]*papua[^<]*<END_COUNTRY/BEGIN_COUNTRYPNG<END_COUNTRY/i # Papua New Guinea
	s/BEGIN_COUNTRY[^<]*paragu[^<]*<END_COUNTRY/BEGIN_COUNTRYPRY<END_COUNTRY/i # Paraguay
	s/BEGIN_COUNTRY[^<]*peru[^<]*<END_COUNTRY/BEGIN_COUNTRYPER<END_COUNTRY/i # Peru
	s/BEGIN_COUNTRY[^<]*philip[^<]*<END_COUNTRY/BEGIN_COUNTRYPHL<END_COUNTRY/i # Philipinnes
	s/BEGIN_COUNTRYpl<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i # Poland
	s/BEGIN_COUNTRYpol<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i # Poland
	s/BEGIN_COUNTRY[^<]*poland[^<]*<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i # Poland
	s/BEGIN_COUNTRYpt<END_COUNTRY/BEGIN_COUNTRYPRT<END_COUNTRY/i # Portugal
	s/BEGIN_COUNTRY[^<]*portug[^<]*<END_COUNTRY/BEGIN_COUNTRYPRT<END_COUNTRY/i # Portugal
	s/BEGIN_COUNTRY[^<]*puerto ri[^<]*<END_COUNTRY/BEGIN_COUNTRYPRI<END_COUNTRY/i # Puero Rico
	s/BEGIN_COUNTRYro<END_COUNTRY/BEGIN_COUNTRYROU<END_COUNTRY/i # Romania
	s/BEGIN_COUNTRY[^<]*romani[^<]*<END_COUNTRY/BEGIN_COUNTRYROU<END_COUNTRY/i # Romania
	s/BEGIN_COUNTRY[^<]*russia[^<]*<END_COUNTRY/BEGIN_COUNTRYRUS<END_COUNTRY/i # Russian Federation
	s/BEGIN_COUNTRY[^<]*marino[^<]*<END_COUNTRY/BEGIN_COUNTRYSMR<END_COUNTRY/i # San Marino
	s/BEGIN_COUNTRY[^<]*saudi[^<]*<END_COUNTRY/BEGIN_COUNTRYSAU<END_COUNTRY/i # Saudi Arabia
	s/BEGIN_COUNTRY[^<]*leone[^<]*<END_COUNTRY/BEGIN_COUNTRYSLE<END_COUNTRY/i # Sierra Leone
	s/BEGIN_COUNTRYsg<END_COUNTRY/BEGIN_COUNTRYSGP<END_COUNTRY/i # Singapore
	s/BEGIN_COUNTRY[^<]*singapore[^<]*<END_COUNTRY/BEGIN_COUNTRYSGP<END_COUNTRY/i # Singapore
	s/BEGIN_COUNTRYsk<END_COUNTRY/BEGIN_COUNTRYSVK<END_COUNTRY/i # Slovokia
	s/BEGIN_COUNTRY[^<]*slovak[^<]*<END_COUNTRY/BEGIN_COUNTRYSVK<END_COUNTRY/i # Slovokia
	s/BEGIN_COUNTRYsi<END_COUNTRY/BEGIN_COUNTRYSVN<END_COUNTRY/i # Slovenia
	s/BEGIN_COUNTRY[^<]*slovenia[^<]*<END_COUNTRY/BEGIN_COUNTRYSVN<END_COUNTRY/i # Slovenia
	s/BEGIN_COUNTRY[^<]*somalia[^<]*<END_COUNTRY/BEGIN_COUNTRYSOM<END_COUNTRY/i # Somalia
	s/BEGIN_COUNTRY[^<]*south afr[^<]*<END_COUNTRY/BEGIN_COUNTRYZAF<END_COUNTRY/i # South Africa
	s/BEGIN_COUNTRYes<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i # Spain
	s/BEGIN_COUNTRY[^<]*espan[^<]*<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i # Spain
	s/BEGIN_COUNTRY[^<]*spain[^<]*<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i # Spain
	s/BEGIN_COUNTRY[^<]*ceylon[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i # Sri Lanka
	s/BEGIN_COUNTRY[^<]*lanka[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i # Sri Lanka
	s/BEGIN_COUNTRY[^<]*syria[^<]*<END_COUNTRY/BEGIN_COUNTRYSYR<END_COUNTRY/i # Syria
	s/BEGIN_COUNTRYse<END_COUNTRY/BEGIN_COUNTRYSWE<END_COUNTRY/i # Sweden
	s/BEGIN_COUNTRYswed[^<]*<END_COUNTRY/BEGIN_COUNTRYSWE<END_COUNTRY/i # Sweden
	s/BEGIN_COUNTRY[^<]*suisse[^<]*<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i # Switzerland
	s/BEGIN_COUNTRY[^<]*switz[^<]*<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i # Switzerland
	s/BEGIN_COUNTRYch<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i # Switzerland
	s/BEGIN_COUNTRY[^<]*taiwan[^<]*<END_COUNTRY/BEGIN_COUNTRYTWN<END_COUNTRY/i # Taiwan
	s/BEGIN_COUNTRY[^<]*tanzan[^<]*<END_COUNTRY/BEGIN_COUNTRYTZA<END_COUNTRY/i # Tanzania
	s/BEGIN_COUNTRY[^<]*thaila[^<]*<END_COUNTRY/BEGIN_COUNTRYTHA<END_COUNTRY/i # Thailand
	s/BEGIN_COUNTRY[^<]*tunisia[^<]*<END_COUNTRY/BEGIN_COUNTRYTUN<END_COUNTRY/i # Tunisia
	s/BEGIN_COUNTRY[^<]*turkey[^<]*<END_COUNTRY/BEGIN_COUNTRYTUR<END_COUNTRY/i # Turkey
	s/BEGIN_COUNTRY[^<]*trinidad[^<]*<END_COUNTRY/BEGIN_COUNTRYTTO<END_COUNTRY/i # Trinibad and Tobago
	s/BEGIN_COUNTRYgb<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # UK
	s/BEGIN_COUNTRY[^<]*uni[^ ]* \?k[^<]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # UK
	s/BEGIN_COUNTRY[^<]*u[\. ]*k[\. ]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # UK
	s/BEGIN_COUNTRY[^<]*britain[^<]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # UK
	s/BEGIN_COUNTRY[^<]*scotland[^<]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i # UK
	s/BEGIN_COUNTRY[^<]*ukrai[^<]*<END_COUNTRY/BEGIN_COUNTRYUKR<END_COUNTRY/i # UKR
	s/BEGIN_COUNTRY[^<]*urugua[^<]*<END_COUNTRY/BEGIN_COUNTRYURY<END_COUNTRY/i # Uruguay
	s/BEGIN_COUNTRY[^<]*u[\. ]*s[\. ]*a[\. ]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i # USA
	s/BEGIN_COUNTRY[^<]*usd\?<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i # USA
	s/BEGIN_COUNTRY[^<]*united sta[^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i # USA
	s/BEGIN_COUNTRY[^<]*[0-9][0-9][0-9][0-9][^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i # USA
	s/BEGIN_COUNTRY[^<]*reston[^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i # USA
	s/BEGIN_COUNTRY/<country desc="">/g 
	s/<END_COUNTRY/<\/country>/g' <<< "$xmldoc")
  }

function fill_empty_fields {
	xmldoc=$(sed 's/<line1 \/>//g' <<< "$xmldoc")
	xmldoc=$(sed 's/\(<address preferred[^>]*>\)/\1<line1>Address line 1 is required<\/line1>/g' <<< "$xmldoc")
	xmldoc=$(sed 's/<line1>Address line 1 is required<\/line1><line1>/<line1>/g' <<< "$xmldoc")

	xmldoc=$(sed 's/<country desc=""><\/country>/<country desc="">CAN<\/country>/g' <<< "$xmldoc")

  }

function delete_blank_addresses {
	xmldoc=$(sed 's#<address preferred="false"><country desc=""></country><start_date>2020-05-..Z</start_date><address_types><address_type desc="Billing">billing</address_type><address_type desc="Shipping">shipping</address_type><address_type desc="Order">order</address_type><address_type desc="Claim">claim</address_type><address_type desc="Payment">payment</address_type><address_type desc="Returns">returns</address_type></address_types></address>##g' <<< "$xmldoc")
	xmldoc=$(sed 's#<address preferred="false"><line1>Address line 1 is required</line1><country desc="Canada">CAN</country><start_date>[^<]*</start_date><address_types><address_type desc="Billing">billing</address_type><address_type desc="Shipping">shipping</address_type><address_type desc="Order">order</address_type><address_type desc="Claim">claim</address_type><address_type desc="Payment">payment</address_type><address_type desc="Returns">returns</address_type></address_types></address>##g' <<< "$xmldoc")

  }

cat vendors.csv | while read vendor

do
	# must encode vendor because spaces, slashes, and other special characters break the API call

	encodedvendor=$(echo -ne "$vendor" | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')

	filevendor=$(echo "$vendor" |sed "s/[^a-z0-9]//ig")
	fileupdate="vendor/update/$filevendor.xml"
	filevendor="vendor/$filevendor.xml"
	
	getstring="https://api-na.hosted.exlibrisgroup.com/almaws/v1/acq/vendors/${encodedvendor}"
	# Retrieves vendor record

	xmldoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Accept: application/xml" -X GET $getstring)
	echo $xmldoc |xmlstarlet fo > "$filevendor"

	delete_blank_addresses
	get_country_code
	fill_empty_fields

	# Counts vendor owners -- only delete the 01UTORONTO entry if at least two vendor owners
	vendorcount=$(echo $xmldoc |xmlstarlet sel -t -m '/vendor/accounts/account/account_libraries' -c 'count(library)')
	if [ $vendorcount -gt 1 ]
	then 

	# Delete only the entry containing the university of toronto code
		xmldoc=$(echo $xmldoc |xmlstarlet ed -d '/vendor/accounts/account/account_libraries/library[code="01UTORONTO_INST"]')
#		xmldoc=$(echo $xmldoc |xmlstarlet ed -d '/vendor/contact_info/addresses/address[@preferred="false"]')
#		xmldoc=$(echo $xmldoc |xmlstarlet ed -u '/vendor/contact_info/addresses/address/country' -v 'USA')

	# check to make sure it worked
fi
	updatedoc=$(curl -s -H "Authorization: apikey $(cat apikey.txt)" -H "Content-Type: application/xml" -X PUT --data "${xmldoc}" $getstring)
	echo $updatedoc |xmlstarlet fo > $fileupdate

	library=$(echo $updatedoc |xmlstarlet sel -t -m '/vendor/accounts/account/account_libraries' -m 'library' -v '.' -o ';' | sed "s/;$//")
	country=$(echo $updatedoc |xmlstarlet sel -t -m '/vendor/contact_info/addresses/address' -m 'country' -v '.' -o ';' | sed "s/;$//")
	echo "Vendor $vendor has now has library (or libraries) $library and country $country associated"
	echo "$vendor	$library	$country" >>  vendors_processed
done

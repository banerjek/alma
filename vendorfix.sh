#!/bin/bash

function get_country_code  {
	# replace start and end country tags to simplify regexes
	xmldoc=$(sed '
	s/<country desc="">/BEGIN_COUNTRY/gi 
	s/<\/country>/<END_COUNTRY/gi 
	s/BEGIN_COUNTRY[^<]*alger[^<]*<END_COUNTRY/<country desc="">DZA<\/country>/gi # Algeria 
	s/BEGIN_COUNTRY[^<]*argent[^<]*<END_COUNTRY/<country desc="">ARG<\/country>/gi # Argentina
	s/BEGIN_COUNTRYar<END_COUNTRY/<country desc="">ARG<\/country>/gi # Argentina
	s/BEGIN_COUNTRY[^<]*armeni[^<]*<END_COUNTRY/<country desc="">ARM<\/country>/gi # Armenia
	s/BEGIN_COUNTRY[^<]*austral[^<]*<END_COUNTRY/<country desc="">AUS<\/country>/gi # Australia
	s/BEGIN_COUNTRYau<END_COUNTRY/<country desc="">AUS<\/country>/gi # Australia
	s/BEGIN_COUNTRYat<END_COUNTRY/<country desc="">AUT<\/country>/gi # Austria
	s/BEGIN_COUNTRY[^<]*baham[^<]*<END_COUNTRY/<country desc="">BHS<\/country>/gi # Bahamas
	s/BEGIN_COUNTRY[^<]*bangla[^<]*<END_COUNTRY/<country desc="">BGD<\/country>/gi # Bangladesh
	s/BEGIN_COUNTRY[^<]*barbados[^<]*<END_COUNTRY/<country desc="">BRB<\/country>/gi # Barbados
	s/BEGIN_COUNTRYbe<END_COUNTRY/<country desc="">BEL<\/country>/gi # Belgium
	s/BEGIN_COUNTRY[^<]*belg[^<]*<END_COUNTRY/<country desc="">BEL<\/country>/gi # Belgium
	s/BEGIN_COUNTRY[^<]*belarus[^<]*<END_COUNTRY/<country desc="">BLR<\/country>/gi # Belarus
	s/BEGIN_COUNTRY[^<]*bermu[^<]*<END_COUNTRY/<country desc="">BMU<\/country>/gi # Bermuda
	s/BEGIN_COUNTRY[^<]*boliv[^<]*<END_COUNTRY/<country desc="">BOL<\/country>/gi # Bolivia
	s/BEGIN_COUNTRY[^<]*botsw[^<]*<END_COUNTRY/<country desc="">BWA<\/country>/gi # Botswana
	s/BEGIN_COUNTRYbr<END_COUNTRY/<country desc="">BRA<\/country>/gi # Brazil
	s/BEGIN_COUNTRYbra[sz]il[^<]*<END_COUNTRY/<country desc="">BRA<\/country>/gi # Brazil
	s/BEGIN_COUNTRY[^<]*brunei[^<]*<END_COUNTRY/<country desc="">BRN<\/country>/gi # Brunei
	s/BEGIN_COUNTRY[^<]*bulgar[^<]*<END_COUNTRY/<country desc="">BGR<\/country>/gi # Bulgaria
	s/BEGIN_COUNTRY<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRYBC<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRYcan\?<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRYcana[^<]*<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRY[^<]*ontario[^<]*<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRY[^<]*oshawa[^<]*<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRY[^<]*quebec[^<]*<END_COUNTRY/<country desc="">CAN<\/country>/gi # Canada
	s/BEGIN_COUNTRYch<END_COUNTRY/<country desc="">CHL<\/country>/gi # Chile
	s/BEGIN_COUNTRY[^<]*chile[^<]*<END_COUNTRY/<country desc="">CHL<\/country>/gi # Chile
	s/BEGIN_COUNTRY[^<]*china[^<]*<END_COUNTRY/<country desc="">CHN<\/country>/gi # China 
	s/BEGIN_COUNTRYcn<END_COUNTRY/<country desc="">CHN<\/country>/gi # China
	s/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/<country desc="">NLD<\/country>/gi # China 
	s/BEGIN_COUNTRYco<END_COUNTRY/<country desc="">COL<\/country>/gi # Colombia
	s/BEGIN_COUNTRY[^<]*colomb[^<]*<END_COUNTRY/<country desc="">COL<\/country>/gi # Colombia
	s/BEGIN_COUNTRYcr<END_COUNTRY/<country desc="">CRI<\/country>/gi # Costa Rica
	s/BEGIN_COUNTRY[^<]*costa ri[^<]*<END_COUNTRY/<country desc="">CRI<\/country>/gi # Costa Rica
	s/BEGIN_COUNTRYhr<END_COUNTRY/<country desc="">HRV<\/country>/gi # Croatia
	s/BEGIN_COUNTRY[^<]*croatia[^<]*<END_COUNTRY/<country desc="">HRV<\/country>/gi # Croatia
	s/BEGIN_COUNTRY[^<]*cuba<END_COUNTRY/<country desc="">CUB<\/country>/gi # Cuba
	s/BEGIN_COUNTRY[^<]*cyprus[^<]*<END_COUNTRY/<country desc="">CYP<\/country>/gi # Cyprus
	s/BEGIN_COUNTRYcz<END_COUNTRY/<country desc="">CZE<\/country>/gi # Czech Republic
	s/BEGIN_COUNTRY[^<]*czech[^<]*<END_COUNTRY/<country desc="">CZE<\/country>/gi # Czech Republic
	s/BEGIN_COUNTRYdk<END_COUNTRY/<country desc="">DNK<\/country>/gi # Denmark
	s/BEGIN_COUNTRYdenm[^<]*<END_COUNTRY/<country desc="">DNK<\/country>/gi # Denmark
	s/BEGIN_COUNTRY[^<]*ecuador[^<]*<END_COUNTRY/<country desc="">ECU<\/country>/gi # Ecuador
	s/BEGIN_COUNTRY[^<]*england[^<]*<END_COUNTRY/<country desc="">GBR<\/country>/gi # England
	s/BEGIN_COUNTRYde<END_COUNTRY/<country desc="">DEU<\/country>/gi # Germany
	s/BEGIN_COUNTRYdeutsch[^<]*<END_COUNTRY/<country desc="">DEU<\/country>/gi # Germany
	s/BEGIN_COUNTRY[^<]*german[^<]*<END_COUNTRY/<country desc="">DEU<\/country>/gi # Germany
	s/BEGIN_COUNTRY[^<]*egypt[^<]*<END_COUNTRY/<country desc="">EGY<\/country>/gi # Egypt
	s/BEGIN_COUNTRY[^<]*estonia[^<]*<END_COUNTRY/<country desc="">LKA<\/country>/gi # Estonia
	s/BEGIN_COUNTRYfi<END_COUNTRY/<country desc="">FIN<\/country>/gi # Finland
	s/BEGIN_COUNTRY[^<]*finland[^<]*<END_COUNTRY/<country desc="">FIN<\/country>/gi # Finland
	s/BEGIN_COUNTRYfr<END_COUNTRY/<country desc="">FRA<\/country>/gi # France
	s/BEGIN_COUNTRY[^<]*france[^<]*<END_COUNTRY/<country desc="">FRA<\/country>/gi # France
	s/BEGIN_COUNTRY[^<]*gambia[^<]*<END_COUNTRY/<country desc="">GMB<\/country>/gi # France
	s/BEGIN_COUNTRY[^<]*georgia[^<]*<END_COUNTRY/<country desc="">GEO<\/country>/gi # Georgia
	s/BEGIN_COUNTRY[^<]*ghana[^<]*<END_COUNTRY/<country desc="">GHA<\/country>/gi # Ghana
	s/BEGIN_COUNTRY[^<]*greece[^<]*<END_COUNTRY/<country desc="">GRC<\/country>/gi # Greece
	s/BEGIN_COUNTRY[^<]*greenla[^<]*<END_COUNTRY/<country desc="">GRN<\/country>/gi # Greenland
	s/BEGIN_COUNTRY[^<]*guam[^<]*<END_COUNTRY/<country desc="">GUM<\/country>/gi # Guam
	s/BEGIN_COUNTRY[^<]*guyana[^<]*<END_COUNTRY/<country desc="">GUY<\/country>/gi # Guyana
	s/BEGIN_COUNTRY[^<]*haiti[^<]*<END_COUNTRY/<country desc="">HTI<\/country>/gi # Haiti
	s/BEGIN_COUNTRY[^<]*hondur[^<]*<END_COUNTRY/<country desc="">HND<\/country>/gi # Honduras
	s/BEGIN_COUNTRY[^<]*hong k[^<]*<END_COUNTRY/<country desc="">HKG<\/country>/gi # Hong Kong
	s/BEGIN_COUNTRYhu<END_COUNTRY/<country desc="">HUN<\/country>/gi # Hungary
	s/BEGIN_COUNTRY[^<]*hungar[^<]*<END_COUNTRY/<country desc="">HUN<\/country>/gi # Hungary
	s/BEGIN_COUNTRY[^<]*iceland[^<]*<END_COUNTRY/<country desc="">ISL<\/country>/gi # Iceland
	s/BEGIN_COUNTRY[^<]*indones[^<]*<END_COUNTRY/<country desc="">IDN<\/country>/gi # Indonesia
	s/BEGIN_COUNTRYindia[^<]*<END_COUNTRY/<country desc="">IND<\/country>/gi # India
	s/BEGIN_COUNTRY[^<]*iran[^<]*<END_COUNTRY/<country desc="">IRN<\/country>/gi # Iran
	s/BEGIN_COUNTRY[^<]*ireland[^<]*<END_COUNTRY/<country desc="">IRL<\/country>/gi # Ireland
	s/BEGIN_COUNTRYis<END_COUNTRY/<country desc="">ISR<\/country>/gi # Israel
	s/BEGIN_COUNTRY[^<]*isreal[^<]*<END_COUNTRY/<country desc="">ISR<\/country>/gi # Israel
	s/BEGIN_COUNTRY[^<]*jerusalem[^<]*<END_COUNTRY/<country desc="">ISR<\/country>/gi # Israel
	s/BEGIN_COUNTRY[^<]*israel[^<]*<END_COUNTRY/<country desc="">ISR<\/country>/gi # Israel
	s/BEGIN_COUNTRYit<END_COUNTRY/<country desc="">ITA<\/country>/gi # Italy
	s/BEGIN_COUNTRY[^<]*ital[^<]*<END_COUNTRY/<country desc="">ITA<\/country>/gi # Italy
	s/BEGIN_COUNTRYjm<END_COUNTRY/<country desc="">JAM<\/country>/gi # Jamaica
	s/BEGIN_COUNTRY[^<]*jamai[^<]*<END_COUNTRY/<country desc="">JAM<\/country>/gi # Jamaica
	s/BEGIN_COUNTRYjo<END_COUNTRY/<country desc="">JOR<\/country>/gi # Jordan
	s/BEGIN_COUNTRY[^<]*jordan[^<]*<END_COUNTRY/<country desc="">ITA<\/country>/gi # Jordan
	s/BEGIN_COUNTRYke<END_COUNTRY/<country desc="">KEN<\/country>/gi # Kenya
	s/BEGIN_COUNTRY[^<]*kenya[^<]*<END_COUNTRY/<country desc="">KEN<\/country>/gi # Kenya
	s/BEGIN_COUNTRYjp<END_COUNTRY/<country desc="">JPN<\/country>/gi # Japan
	s/BEGIN_COUNTRY[^<]*japan[^<]*<END_COUNTRY/<country desc="">ITA<\/country>/gi # Japan
	s/BEGIN_COUNTRY[^<]*korea[^<]*<END_COUNTRY/<country desc="">KOR<\/country>/gi # Korea
	s/BEGIN_COUNTRY[^<]*kuwait[^<]*<END_COUNTRY/<country desc="">KWT<\/country>/gi # Kuwait
	s/BEGIN_COUNTRYllv<END_COUNTRY/<country desc="">LVA<\/country>/gi # Latvia
	s/BEGIN_COUNTRY[^<]*latvia[^<]*<END_COUNTRY/<country desc="">LVA<\/country>/gi # Latvia
	s/BEGIN_COUNTRYlb<END_COUNTRY/<country desc="">LBN<\/country>/gi # Lebanon
	s/BEGIN_COUNTRY[^<]*lebanon[^<]*<END_COUNTRY/<country desc="">LBN<\/country>/gi # Lebanon
	s/BEGIN_COUNTRY[^<]*lithuan[^<]*<END_COUNTRY/<country desc="">LTU<\/country>/gi # Lithuania
	s/BEGIN_COUNTRY[^<]*luxemb[^<]*<END_COUNTRY/<country desc="">LUX<\/country>/gi # Luxembourg
	s/BEGIN_COUNTRY[^<]*macedonia[^<]*<END_COUNTRY/<country desc="">MKD<\/country>/gi # Macedonia
	s/BEGIN_COUNTRY[^<]*malas[^<]*<END_COUNTRY/<country desc="">MYS<\/country>/gi # Malta
	s/BEGIN_COUNTRY[^<]*malay[^<]*<END_COUNTRY/<country desc="">MYS<\/country>/gi # Malta
	s/BEGIN_COUNTRY[^<]*malta[^<]*<END_COUNTRY/<country desc="">MLT<\/country>/gi # Malta
	s/BEGIN_COUNTRY[^<]*moroc[^<]*<END_COUNTRY/<country desc="">MAR<\/country>/gi # Morocco
	s/BEGIN_COUNTRYmx<END_COUNTRY/<country desc="">MEX<\/country>/gi # Mexico
	s/BEGIN_COUNTRY[^<]*mexico[^<]*<END_COUNTRY/<country desc="">MEX<\/country>/gi # Mexico
	s/BEGIN_COUNTRYnm<END_COUNTRY/<country desc="">NAM<\/country>/gi # Nambia
	s/BEGIN_COUNTRY[^<]*nambia[^<]*<END_COUNTRY/<country desc="">NAM<\/country>/gi # Nambia
	s/BEGIN_COUNTRYnl<END_COUNTRY/<country desc="">NLD<\/country>/gi # Netherlands
	s/BEGIN_COUNTRY[^<]*nederl[^<]*<END_COUNTRY/<country desc="">NLD<\/country>/gi # Netherlands
	s/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/<country desc="">NLD<\/country>/gi # Netherlands
	s/BEGIN_COUNTRY[^<]*nepal[^<]*<END_COUNTRY/<country desc="">NPL<\/country>/gi # Nepal
	s/BEGIN_COUNTRY[^<]*caledonia[^<]*<END_COUNTRY/<country desc="">NCL<\/country>/gi # New Calendonia
	s/BEGIN_COUNTRYnz<END_COUNTRY/<country desc="">NZL<\/country>/gi # New Zealand
	s/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/<country desc="">NZL<\/country>/gi # New Zealand
	s/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/<country desc="">NZL<\/country>/gi # New Zealand
	s/BEGIN_COUNTRY[^<]*aotearoa[^<]*<END_COUNTRY/<country desc="">NZL<\/country>/gi # New Zealand
	s/BEGIN_COUNTRY[^<]*nigeria[^<]*<END_COUNTRY/<country desc="">NGA<\/country>/gi # Nigeria
	s/BEGIN_COUNTRYno<END_COUNTRY/<country desc="">NOR<\/country>/gi # Norway
	s/BEGIN_COUNTRY[^<]*pakist[^<]*<END_COUNTRY/<country desc="">PAK<\/country>/gi # Pakistan
	s/BEGIN_COUNTRY[^<]*papua[^<]*<END_COUNTRY/<country desc="">PNG<\/country>/gi # Papua New Guinea
	s/BEGIN_COUNTRY[^<]*paragu[^<]*<END_COUNTRY/<country desc="">PRY<\/country>/gi # Paraguay
	s/BEGIN_COUNTRY[^<]*peru[^<]*<END_COUNTRY/<country desc="">PER<\/country>/gi # Peru
	s/BEGIN_COUNTRY[^<]*philip[^<]*<END_COUNTRY/<country desc="">PHL<\/country>/gi # Philipinnes
	s/BEGIN_COUNTRYpl<END_COUNTRY/<country desc="">POL<\/country>/gi # Poland
	s/BEGIN_COUNTRYpol<END_COUNTRY/<country desc="">POL<\/country>/gi # Poland
	s/BEGIN_COUNTRY[^<]*poland[^<]*<END_COUNTRY/<country desc="">POL<\/country>/gi # Poland
	s/BEGIN_COUNTRYpt<END_COUNTRY/<country desc="">PRT<\/country>/gi # Portugal
	s/BEGIN_COUNTRY[^<]*portug[^<]*<END_COUNTRY/<country desc="">PRT<\/country>/gi # Portugal
	s/BEGIN_COUNTRY[^<]*puerto ri[^<]*<END_COUNTRY/<country desc="">PRI<\/country>/gi # Puero Rico
	s/BEGIN_COUNTRYro<END_COUNTRY/<country desc="">ROU<\/country>/gi # Romania
	s/BEGIN_COUNTRY[^<]*romani[^<]*<END_COUNTRY/<country desc="">ROU<\/country>/gi # Romania
	s/BEGIN_COUNTRY[^<]*russia[^<]*<END_COUNTRY/<country desc="">RUS<\/country>/gi # Russian Federation
	s/BEGIN_COUNTRY[^<]*marino[^<]*<END_COUNTRY/<country desc="">SMR<\/country>/gi # San Marino
	s/BEGIN_COUNTRY[^<]*saudi[^<]*<END_COUNTRY/<country desc="">SAU<\/country>/gi # Saudi Arabia
	s/BEGIN_COUNTRY[^<]*leone[^<]*<END_COUNTRY/<country desc="">SLE<\/country>/gi # Sierra Leone
	s/BEGIN_COUNTRYsg<END_COUNTRY/<country desc="">SGP<\/country>/gi # Singapore
	s/BEGIN_COUNTRY[^<]*singapore[^<]*<END_COUNTRY/<country desc="">SGP<\/country>/gi # Singapore
	s/BEGIN_COUNTRYsk<END_COUNTRY/<country desc="">SVK<\/country>/gi # Slovokia
	s/BEGIN_COUNTRY[^<]*slovak[^<]*<END_COUNTRY/<country desc="">SVK<\/country>/gi # Slovokia
	s/BEGIN_COUNTRYsi<END_COUNTRY/<country desc="">SVN<\/country>/gi # Slovenia
	s/BEGIN_COUNTRY[^<]*slovenia[^<]*<END_COUNTRY/<country desc="">SVN<\/country>/gi # Slovenia
	s/BEGIN_COUNTRY[^<]*somalia[^<]*<END_COUNTRY/<country desc="">SOM<\/country>/gi # Somalia
	s/BEGIN_COUNTRY[^<]*south afr[^<]*<END_COUNTRY/<country desc="">ZAF<\/country>/gi # South Africa
	s/BEGIN_COUNTRYes<END_COUNTRY/<country desc="">ESP<\/country>/gi # Spain
	s/BEGIN_COUNTRY[^<]*espan[^<]*<END_COUNTRY/<country desc="">ESP<\/country>/gi # Spain
	s/BEGIN_COUNTRY[^<]*spain[^<]*<END_COUNTRY/<country desc="">ESP<\/country>/gi # Spain
	s/BEGIN_COUNTRY[^<]*ceylon[^<]*<END_COUNTRY/<country desc="">LKA<\/country>/gi # Sri Lanka
	s/BEGIN_COUNTRY[^<]*lanka[^<]*<END_COUNTRY/<country desc="">LKA<\/country>/gi # Sri Lanka
	s/BEGIN_COUNTRY[^<]*syria[^<]*<END_COUNTRY/<country desc="">SYR<\/country>/gi # Syria
	s/BEGIN_COUNTRYse<END_COUNTRY/<country desc="">SWE<\/country>/gi # Sweden
	s/BEGIN_COUNTRY[^<]*suisse[^<]*<END_COUNTRY/<country desc="">CHE<\/country>/gi # Switzerland
	s/BEGIN_COUNTRY[^<]*switz[^<]*<END_COUNTRY/<country desc="">CHE<\/country>/gi # Switzerland
	s/BEGIN_COUNTRYch<END_COUNTRY/<country desc="">CHE<\/country>/gi # Switzerland
	s/BEGIN_COUNTRY[^<]*taiwan[^<]*<END_COUNTRY/<country desc="">TWN<\/country>/gi # Taiwan
	s/BEGIN_COUNTRY[^<]*tanzan[^<]*<END_COUNTRY/<country desc="">TZA<\/country>/gi # Tanzania
	s/BEGIN_COUNTRY[^<]*thaila[^<]*<END_COUNTRY/<country desc="">THA<\/country>/gi # Thailand
	s/BEGIN_COUNTRY[^<]*tunisia[^<]*<END_COUNTRY/<country desc="">TUN<\/country>/gi # Tunisia
	s/BEGIN_COUNTRY[^<]*turkey[^<]*<END_COUNTRY/<country desc="">TUR<\/country>/gi # Turkey
	s/BEGIN_COUNTRY[^<]*trinidad[^<]*<END_COUNTRY/<country desc="">TTO<\/country>/gi # Trinibad and Tobago
	s/BEGIN_COUNTRYgb<END_COUNTRY/<country desc="">UK<\/country>/gi # UK
	s/BEGIN_COUNTRY[^<]*uni[^ ]* \?k[^<]*<END_COUNTRY/<country desc="">UK<\/country>/gi # UK
	s/BEGIN_COUNTRY[^<]*u[\. ]*k[\. ]*<END_COUNTRY/<country desc="">UK<\/country>/gi # UK
	s/BEGIN_COUNTRY[^<]*britain[^<]*<END_COUNTRY/<country desc="">UK<\/country>/gi # UK
	s/BEGIN_COUNTRY[^<]*scotland[^<]*<END_COUNTRY/<country desc="">UK<\/country>/gi # UK
	s/BEGIN_COUNTRY[^<]*ukrai[^<]*<END_COUNTRY/<country desc="">UKR<\/country>/gi # UKR
	s/BEGIN_COUNTRY[^<]*urugua[^<]*<END_COUNTRY/<country desc="">URY<\/country>/gi # Uruguay
	s/BEGIN_COUNTRY[^<]*u[\. ]*s[\. ]*a[\. ]*<END_COUNTRY/<country desc="">USA<\/country>/gi # USA
	s/BEGIN_COUNTRY[^<]*usd\?<END_COUNTRY/<country desc="">USA<\/country>/gi # USA
	s/BEGIN_COUNTRY[^<]*united sta[^<]*<END_COUNTRY/<country desc="">USA<\/country>/gi # USA
	s/BEGIN_COUNTRY[^<]*[0-9][0-9][0-9][0-9][^<]*<END_COUNTRY/<country desc="">USA<\/country>/gi # USA
	s/BEGIN_COUNTRY[^<]*reston[^<]*<END_COUNTRY/<country desc="">USA<\/country>/gi # USA
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
	xmldoc=$(sed 's#<address preferred="false"><country desc=""></country><start_date>2019-12-11Z</start_date><address_types><address_type desc="Billing">billing</address_type><address_type desc="Shipping">shipping</address_type><address_type desc="Order">order</address_type><address_type desc="Claim">claim</address_type><address_type desc="Payment">payment</address_type><address_type desc="Returns">returns</address_type></address_types></address>##g' <<< "$xmldoc")
	xmldoc=$(sed 's#<address preferred="false"><line1>Address line 1 is required</line1><country desc="Canada">CAN</country><start_date>[^<]*</start_date><address_types><address_type desc="Billing">billing</address_type><address_type desc="Shipping">shipping</address_type><address_type desc="Order">order</address_type><address_type desc="Claim">claim</address_type><address_type desc="Payment">payment</address_type><address_type desc="Returns">returns</address_type></address_types></address>##g' <<< "$xmldoc")

  }

cat vendors | while read vendor

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
	echo $xmldoc |xmlstarlet fo > $fileupdate

	library=$(echo $xmldoc |xmlstarlet sel -t -m '/vendor/accounts/account/account_libraries' -m 'library' -v '.' -o ';' | sed "s/;$//")
	country=$(echo $xmldoc |xmlstarlet sel -t -m '/vendor/contact_info/addresses/address' -m 'country' -v '.' -o ';' | sed "s/;$//")
	echo "Vendor $vendor has now has library (or libraries) $library and country $country associated"
	echo "$vendor	$library	$country" >>  vendors_processed
done

#!/bin/bash

function get_country_code  {
	# replace start and end country tags to simplify regexes
	xmldoc=$(sed 's/<country desc="">/BEGIN_COUNTRY/gi' <<< "$xmldoc") # Algeria 
	xmldoc=$(sed 's/<\/country>/<END_COUNTRY/gi' <<< "$xmldoc") # Algeria 
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*alger[^<]*<END_COUNTRY/BEGIN_COUNTRYDZA<END_COUNTRY/i' <<< "$xmldoc") # Algeria 
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*argent[^<]*<END_COUNTRY/BEGIN_COUNTRYARG<END_COUNTRY/i' <<< "$xmldoc") # Argentina
	xmldoc=$(sed 's/BEGIN_COUNTRYar<END_COUNTRY/BEGIN_COUNTRYARG<END_COUNTRY/i' <<< "$xmldoc") # Argentina
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*armeni[^<]*<END_COUNTRY/BEGIN_COUNTRYARM<END_COUNTRY/i' <<< "$xmldoc") # Armenia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*austral[^<]*<END_COUNTRY/BEGIN_COUNTRYAUS<END_COUNTRY/i' <<< "$xmldoc") # Australia
	xmldoc=$(sed 's/BEGIN_COUNTRYau<END_COUNTRY/BEGIN_COUNTRYAUS<END_COUNTRY/i' <<< "$xmldoc") # Australia
	xmldoc=$(sed 's/BEGIN_COUNTRYat<END_COUNTRY/BEGIN_COUNTRYAUT<END_COUNTRY/i' <<< "$xmldoc") # Austria
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*baham[^<]*<END_COUNTRY/BEGIN_COUNTRYBHS<END_COUNTRY/i' <<< "$xmldoc") # Bahamas
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*bangla[^<]*<END_COUNTRY/BEGIN_COUNTRYBGD<END_COUNTRY/i' <<< "$xmldoc") # Bangladesh
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*barbados[^<]*<END_COUNTRY/BEGIN_COUNTRYBRB<END_COUNTRY/i' <<< "$xmldoc") # Barbados
	xmldoc=$(sed 's/BEGIN_COUNTRYbe<END_COUNTRY/BEGIN_COUNTRYBEL<END_COUNTRY/i' <<< "$xmldoc") # Belgium
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*belg[^<]*<END_COUNTRY/BEGIN_COUNTRYBEL<END_COUNTRY/i' <<< "$xmldoc") # Belgium
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*belarus[^<]*<END_COUNTRY/BEGIN_COUNTRYBLR<END_COUNTRY/i' <<< "$xmldoc") # Belarus
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*bermu[^<]*<END_COUNTRY/BEGIN_COUNTRYBMU<END_COUNTRY/i' <<< "$xmldoc") # Bermuda
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*boliv[^<]*<END_COUNTRY/BEGIN_COUNTRYBOL<END_COUNTRY/i' <<< "$xmldoc") # Bolivia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*botsw[^<]*<END_COUNTRY/BEGIN_COUNTRYBWA<END_COUNTRY/i' <<< "$xmldoc") # Botswana
	xmldoc=$(sed 's/BEGIN_COUNTRYbr<END_COUNTRY/BEGIN_COUNTRYBRA<END_COUNTRY/i' <<< "$xmldoc") # Brazil
	xmldoc=$(sed 's/BEGIN_COUNTRYbra[sz]il[^<]*<END_COUNTRY/BEGIN_COUNTRYBRA<END_COUNTRY/i' <<< "$xmldoc") # Brazil
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*brunei[^<]*<END_COUNTRY/BEGIN_COUNTRYBRN<END_COUNTRY/i' <<< "$xmldoc") # Brunei
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*bulgar[^<]*<END_COUNTRY/BEGIN_COUNTRYBGR<END_COUNTRY/i' <<< "$xmldoc") # Bulgaria
	xmldoc=$(sed 's/BEGIN_COUNTRY<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRYBC<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRYcan\?<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRYcana[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ontario[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*oshawa[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*quebec[^<]*<END_COUNTRY/BEGIN_COUNTRYCAN<END_COUNTRY/i' <<< "$xmldoc") # Canada
	xmldoc=$(sed 's/BEGIN_COUNTRYch<END_COUNTRY/BEGIN_COUNTRYCHL<END_COUNTRY/i' <<< "$xmldoc") # Chile
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*chile[^<]*<END_COUNTRY/BEGIN_COUNTRYCHL<END_COUNTRY/i' <<< "$xmldoc") # Chile
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*china[^<]*<END_COUNTRY/BEGIN_COUNTRYCHN<END_COUNTRY/i' <<< "$xmldoc") # China 
	xmldoc=$(sed 's/BEGIN_COUNTRYcn<END_COUNTRY/BEGIN_COUNTRYCHN<END_COUNTRY/i' <<< "$xmldoc") # China
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i' <<< "$xmldoc") # China 
	xmldoc=$(sed 's/BEGIN_COUNTRYco<END_COUNTRY/BEGIN_COUNTRYCOL<END_COUNTRY/i' <<< "$xmldoc") # Colombia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*colomb[^<]*<END_COUNTRY/BEGIN_COUNTRYCOL<END_COUNTRY/i' <<< "$xmldoc") # Colombia
	xmldoc=$(sed 's/BEGIN_COUNTRYcr<END_COUNTRY/BEGIN_COUNTRYCRI<END_COUNTRY/i' <<< "$xmldoc") # Costa Rica
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*costa ri[^<]*<END_COUNTRY/BEGIN_COUNTRYCRI<END_COUNTRY/i' <<< "$xmldoc") # Costa Rica
	xmldoc=$(sed 's/BEGIN_COUNTRYhr<END_COUNTRY/BEGIN_COUNTRYHRV<END_COUNTRY/i' <<< "$xmldoc") # Croatia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*croatia[^<]*<END_COUNTRY/BEGIN_COUNTRYHRV<END_COUNTRY/i' <<< "$xmldoc") # Croatia
	xmldoc=$(sed 's/BEGIN_COUNTRYcuba<END_COUNTRY/BEGIN_COUNTRYCUB<END_COUNTRY/i' <<< "$xmldoc") # Cuba
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*cyprus[^<]*<END_COUNTRY/BEGIN_COUNTRYCYP<END_COUNTRY/i' <<< "$xmldoc") # Cyprus
	xmldoc=$(sed 's/BEGIN_COUNTRYcz<END_COUNTRY/BEGIN_COUNTRYCZE<END_COUNTRY/i' <<< "$xmldoc") # Czech Republic
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*czech[^<]*<END_COUNTRY/BEGIN_COUNTRYCZE<END_COUNTRY/i' <<< "$xmldoc") # Czech Republic
	xmldoc=$(sed 's/BEGIN_COUNTRYdk<END_COUNTRY/BEGIN_COUNTRYDNK<END_COUNTRY/i' <<< "$xmldoc") # Denmark
	xmldoc=$(sed 's/BEGIN_COUNTRYdenm[^<]*<END_COUNTRY/BEGIN_COUNTRYDNK<END_COUNTRY/i' <<< "$xmldoc") # Denmark
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ecuador[^<]*<END_COUNTRY/BEGIN_COUNTRYECU<END_COUNTRY/i' <<< "$xmldoc") # Ecuador
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*england[^<]*<END_COUNTRY/BEGIN_COUNTRYGBR<END_COUNTRY/i' <<< "$xmldoc") # England
	xmldoc=$(sed 's/BEGIN_COUNTRYde<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i' <<< "$xmldoc") # Germany
	xmldoc=$(sed 's/BEGIN_COUNTRYdeutsch[^<]*<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i' <<< "$xmldoc") # Germany
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*german[^<]*<END_COUNTRY/BEGIN_COUNTRYDEU<END_COUNTRY/i' <<< "$xmldoc") # Germany
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*egypt[^<]*<END_COUNTRY/BEGIN_COUNTRYEGY<END_COUNTRY/i' <<< "$xmldoc") # Egypt
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*estonia[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i' <<< "$xmldoc") # Estonia
	xmldoc=$(sed 's/BEGIN_COUNTRYfi<END_COUNTRY/BEGIN_COUNTRYFIN<END_COUNTRY/i' <<< "$xmldoc") # Finland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*finland[^<]*<END_COUNTRY/BEGIN_COUNTRYFIN<END_COUNTRY/i' <<< "$xmldoc") # Finland
	xmldoc=$(sed 's/BEGIN_COUNTRYfr<END_COUNTRY/BEGIN_COUNTRYFRA<END_COUNTRY/i' <<< "$xmldoc") # France
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*france[^<]*<END_COUNTRY/BEGIN_COUNTRYFRA<END_COUNTRY/i' <<< "$xmldoc") # France
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*gambia[^<]*<END_COUNTRY/BEGIN_COUNTRYGMB<END_COUNTRY/i' <<< "$xmldoc") # France
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*georgia[^<]*<END_COUNTRY/BEGIN_COUNTRYGEO<END_COUNTRY/i' <<< "$xmldoc") # Georgia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ghana[^<]*<END_COUNTRY/BEGIN_COUNTRYGHA<END_COUNTRY/i' <<< "$xmldoc") # Ghana
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*greece[^<]*<END_COUNTRY/BEGIN_COUNTRYGRC<END_COUNTRY/i' <<< "$xmldoc") # Greece
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*greenla[^<]*<END_COUNTRY/BEGIN_COUNTRYGRN<END_COUNTRY/i' <<< "$xmldoc") # Greenland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*guam[^<]*<END_COUNTRY/BEGIN_COUNTRYGUM<END_COUNTRY/i' <<< "$xmldoc") # Guam
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*guyana[^<]*<END_COUNTRY/BEGIN_COUNTRYGUY<END_COUNTRY/i' <<< "$xmldoc") # Guyana
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*haiti[^<]*<END_COUNTRY/BEGIN_COUNTRYHTI<END_COUNTRY/i' <<< "$xmldoc") # Haiti
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*hondur[^<]*<END_COUNTRY/BEGIN_COUNTRYHND<END_COUNTRY/i' <<< "$xmldoc") # Honduras
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*hong k[^<]*<END_COUNTRY/BEGIN_COUNTRYHKG<END_COUNTRY/i' <<< "$xmldoc") # Hong Kong
	xmldoc=$(sed 's/BEGIN_COUNTRYhu<END_COUNTRY/BEGIN_COUNTRYHUN<END_COUNTRY/i' <<< "$xmldoc") # Hungary
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*hungar[^<]*<END_COUNTRY/BEGIN_COUNTRYHUN<END_COUNTRY/i' <<< "$xmldoc") # Hungary
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*iceland[^<]*<END_COUNTRY/BEGIN_COUNTRYISL<END_COUNTRY/i' <<< "$xmldoc") # Iceland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*indones[^<]*<END_COUNTRY/BEGIN_COUNTRYIDN<END_COUNTRY/i' <<< "$xmldoc") # Indonesia
	xmldoc=$(sed 's/BEGIN_COUNTRYindia[^<]*<END_COUNTRY/BEGIN_COUNTRYIND<END_COUNTRY/i' <<< "$xmldoc") # India
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*iran[^<]*<END_COUNTRY/BEGIN_COUNTRYIRN<END_COUNTRY/i' <<< "$xmldoc") # Iran
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ireland[^<]*<END_COUNTRY/BEGIN_COUNTRYIRL<END_COUNTRY/i' <<< "$xmldoc") # Ireland
	xmldoc=$(sed 's/BEGIN_COUNTRYis<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i' <<< "$xmldoc") # Israel
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*isreal[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i' <<< "$xmldoc") # Israel
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*jerusalem[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i' <<< "$xmldoc") # Israel
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*israel[^<]*<END_COUNTRY/BEGIN_COUNTRYISR<END_COUNTRY/i' <<< "$xmldoc") # Israel
	xmldoc=$(sed 's/BEGIN_COUNTRYit<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i' <<< "$xmldoc") # Italy
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ital[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i' <<< "$xmldoc") # Italy
	xmldoc=$(sed 's/BEGIN_COUNTRYjm<END_COUNTRY/BEGIN_COUNTRYJAM<END_COUNTRY/i' <<< "$xmldoc") # Jamaica
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*jamai[^<]*<END_COUNTRY/BEGIN_COUNTRYJAM<END_COUNTRY/i' <<< "$xmldoc") # Jamaica
	xmldoc=$(sed 's/BEGIN_COUNTRYjo<END_COUNTRY/BEGIN_COUNTRYJOR<END_COUNTRY/i' <<< "$xmldoc") # Jordan
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*jordan[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i' <<< "$xmldoc") # Jordan
	xmldoc=$(sed 's/BEGIN_COUNTRYke<END_COUNTRY/BEGIN_COUNTRYKEN<END_COUNTRY/i' <<< "$xmldoc") # Kenya
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*kenya[^<]*<END_COUNTRY/BEGIN_COUNTRYKEN<END_COUNTRY/i' <<< "$xmldoc") # Kenya
	xmldoc=$(sed 's/BEGIN_COUNTRYjp<END_COUNTRY/BEGIN_COUNTRYJPN<END_COUNTRY/i' <<< "$xmldoc") # Japan
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*japan[^<]*<END_COUNTRY/BEGIN_COUNTRYITA<END_COUNTRY/i' <<< "$xmldoc") # Japan
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*korea[^<]*<END_COUNTRY/BEGIN_COUNTRYKOR<END_COUNTRY/i' <<< "$xmldoc") # Korea
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*kuwait[^<]*<END_COUNTRY/BEGIN_COUNTRYKWT<END_COUNTRY/i' <<< "$xmldoc") # Kuwait
	xmldoc=$(sed 's/BEGIN_COUNTRYlv<END_COUNTRY/BEGIN_COUNTRYLVA<END_COUNTRY/i' <<< "$xmldoc") # Latvia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*latvia[^<]*<END_COUNTRY/BEGIN_COUNTRYLVA<END_COUNTRY/i' <<< "$xmldoc") # Latvia
	xmldoc=$(sed 's/BEGIN_COUNTRYlb<END_COUNTRY/BEGIN_COUNTRYLBN<END_COUNTRY/i' <<< "$xmldoc") # Lebanon
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*lebanon[^<]*<END_COUNTRY/BEGIN_COUNTRYLBN<END_COUNTRY/i' <<< "$xmldoc") # Lebanon
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*lithuan[^<]*<END_COUNTRY/BEGIN_COUNTRYLTU<END_COUNTRY/i' <<< "$xmldoc") # Lithuania
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*luxemb[^<]*<END_COUNTRY/BEGIN_COUNTRYLUX<END_COUNTRY/i' <<< "$xmldoc") # Luxembourg
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*macedonia[^<]*<END_COUNTRY/BEGIN_COUNTRYMKD<END_COUNTRY/i' <<< "$xmldoc") # Macedonia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*malta[^<]*<END_COUNTRY/BEGIN_COUNTRYMLT<END_COUNTRY/i' <<< "$xmldoc") # Malta
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*moroc[^<]*<END_COUNTRY/BEGIN_COUNTRYMAR<END_COUNTRY/i' <<< "$xmldoc") # Morocco
	xmldoc=$(sed 's/BEGIN_COUNTRYmx<END_COUNTRY/BEGIN_COUNTRYMEX<END_COUNTRY/i' <<< "$xmldoc") # Mexico
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*mexico[^<]*<END_COUNTRY/BEGIN_COUNTRYMEX<END_COUNTRY/i' <<< "$xmldoc") # Mexico
	xmldoc=$(sed 's/BEGIN_COUNTRYnm<END_COUNTRY/BEGIN_COUNTRYNAM<END_COUNTRY/i' <<< "$xmldoc") # Nambia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*nambia[^<]*<END_COUNTRY/BEGIN_COUNTRYNAM<END_COUNTRY/i' <<< "$xmldoc") # Nambia
	xmldoc=$(sed 's/BEGIN_COUNTRYnl<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i' <<< "$xmldoc") # Netherlands
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*nederl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i' <<< "$xmldoc") # Netherlands
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*netherl[^<]*<END_COUNTRY/BEGIN_COUNTRYNLD<END_COUNTRY/i' <<< "$xmldoc") # Netherlands
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*nepal[^<]*<END_COUNTRY/BEGIN_COUNTRYNPL<END_COUNTRY/i' <<< "$xmldoc") # Nepal
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*caledonia[^<]*<END_COUNTRY/BEGIN_COUNTRYNCL<END_COUNTRY/i' <<< "$xmldoc") # New Calendonia
	xmldoc=$(sed 's/BEGIN_COUNTRYnz<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i' <<< "$xmldoc") # New Zealand
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i' <<< "$xmldoc") # New Zealand
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*zeala[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i' <<< "$xmldoc") # New Zealand
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*aotearoa[^<]*<END_COUNTRY/BEGIN_COUNTRYNZL<END_COUNTRY/i' <<< "$xmldoc") # New Zealand
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*nigeria[^<]*<END_COUNTRY/BEGIN_COUNTRYNGA<END_COUNTRY/i' <<< "$xmldoc") # Nigeria
	xmldoc=$(sed 's/BEGIN_COUNTRYno<END_COUNTRY/BEGIN_COUNTRYNOR<END_COUNTRY/i' <<< "$xmldoc") # Norway
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*pakist[^<]*<END_COUNTRY/BEGIN_COUNTRYPAK<END_COUNTRY/i' <<< "$xmldoc") # Pakistan
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*papua[^<]*<END_COUNTRY/BEGIN_COUNTRYPNG<END_COUNTRY/i' <<< "$xmldoc") # Papua New Guinea
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*paragu[^<]*<END_COUNTRY/BEGIN_COUNTRYPRY<END_COUNTRY/i' <<< "$xmldoc") # Paraguay
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*peru[^<]*<END_COUNTRY/BEGIN_COUNTRYPER<END_COUNTRY/i' <<< "$xmldoc") # Peru
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*philip[^<]*<END_COUNTRY/BEGIN_COUNTRYPHL<END_COUNTRY/i' <<< "$xmldoc") # Philipinnes
	xmldoc=$(sed 's/BEGIN_COUNTRYpl<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i' <<< "$xmldoc") # Poland
	xmldoc=$(sed 's/BEGIN_COUNTRYpol<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i' <<< "$xmldoc") # Poland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*poland[^<]*<END_COUNTRY/BEGIN_COUNTRYPOL<END_COUNTRY/i' <<< "$xmldoc") # Poland
	xmldoc=$(sed 's/BEGIN_COUNTRYpt<END_COUNTRY/BEGIN_COUNTRYPRT<END_COUNTRY/i' <<< "$xmldoc") # Portugal
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*portug[^<]*<END_COUNTRY/BEGIN_COUNTRYPRT<END_COUNTRY/i' <<< "$xmldoc") # Portugal
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*puerto ri[^<]*<END_COUNTRY/BEGIN_COUNTRYPRI<END_COUNTRY/i' <<< "$xmldoc") # Puero Rico
	xmldoc=$(sed 's/BEGIN_COUNTRYro<END_COUNTRY/BEGIN_COUNTRYROU<END_COUNTRY/i' <<< "$xmldoc") # Romania
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*romani[^<]*<END_COUNTRY/BEGIN_COUNTRYROU<END_COUNTRY/i' <<< "$xmldoc") # Romania
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*russia[^<]*<END_COUNTRY/BEGIN_COUNTRYRUS<END_COUNTRY/i' <<< "$xmldoc") # Russian Federation
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*marino[^<]*<END_COUNTRY/BEGIN_COUNTRYSMR<END_COUNTRY/i' <<< "$xmldoc") # San Marino
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*saudi[^<]*<END_COUNTRY/BEGIN_COUNTRYSAU<END_COUNTRY/i' <<< "$xmldoc") # Saudi Arabia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*leone[^<]*<END_COUNTRY/BEGIN_COUNTRYSLE<END_COUNTRY/i' <<< "$xmldoc") # Sierra Leone
	xmldoc=$(sed 's/BEGIN_COUNTRYsg<END_COUNTRY/BEGIN_COUNTRYSGP<END_COUNTRY/i' <<< "$xmldoc") # Singapore
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*singapore[^<]*<END_COUNTRY/BEGIN_COUNTRYSGP<END_COUNTRY/i' <<< "$xmldoc") # Singapore
	xmldoc=$(sed 's/BEGIN_COUNTRYsk<END_COUNTRY/BEGIN_COUNTRYSVK<END_COUNTRY/i' <<< "$xmldoc") # Slovokia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*slovak[^<]*<END_COUNTRY/BEGIN_COUNTRYSVK<END_COUNTRY/i' <<< "$xmldoc") # Slovokia
	xmldoc=$(sed 's/BEGIN_COUNTRYsi<END_COUNTRY/BEGIN_COUNTRYSVN<END_COUNTRY/i' <<< "$xmldoc") # Slovenia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*slovenia[^<]*<END_COUNTRY/BEGIN_COUNTRYSVN<END_COUNTRY/i' <<< "$xmldoc") # Slovenia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*somalia[^<]*<END_COUNTRY/BEGIN_COUNTRYSOM<END_COUNTRY/i' <<< "$xmldoc") # Somalia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*south afr[^<]*<END_COUNTRY/BEGIN_COUNTRYZAF<END_COUNTRY/i' <<< "$xmldoc") # South Africa
	xmldoc=$(sed 's/BEGIN_COUNTRYes<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i' <<< "$xmldoc") # Spain
	xmldoc=$(sed 's/BEGIN_COUNTRYespan[^<]*<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i' <<< "$xmldoc") # Spain
	xmldoc=$(sed 's/BEGIN_COUNTRYspain[^<]*<END_COUNTRY/BEGIN_COUNTRYESP<END_COUNTRY/i' <<< "$xmldoc") # Spain
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ceylon[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i' <<< "$xmldoc") # Sri Lanka
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*lanka[^<]*<END_COUNTRY/BEGIN_COUNTRYLKA<END_COUNTRY/i' <<< "$xmldoc") # Sri Lanka
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*syria[^<]*<END_COUNTRY/BEGIN_COUNTRYSYR<END_COUNTRY/i' <<< "$xmldoc") # Syria
	xmldoc=$(sed 's/BEGIN_COUNTRYse<END_COUNTRY/BEGIN_COUNTRYSWE<END_COUNTRY/i' <<< "$xmldoc") # Sweden
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*suisse[^<]*<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i' <<< "$xmldoc") # Switzerland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*switz[^<]*<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i' <<< "$xmldoc") # Switzerland
	xmldoc=$(sed 's/BEGIN_COUNTRYch<END_COUNTRY/BEGIN_COUNTRYCHE<END_COUNTRY/i' <<< "$xmldoc") # Switzerland
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*taiwan[^<]*<END_COUNTRY/BEGIN_COUNTRYTWN<END_COUNTRY/i' <<< "$xmldoc") # Taiwan
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*tanzan[^<]*<END_COUNTRY/BEGIN_COUNTRYTZA<END_COUNTRY/i' <<< "$xmldoc") # Tanzania
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*thaila[^<]*<END_COUNTRY/BEGIN_COUNTRYTHA<END_COUNTRY/i' <<< "$xmldoc") # Thailand
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*tunisia[^<]*<END_COUNTRY/BEGIN_COUNTRYTUN<END_COUNTRY/i' <<< "$xmldoc") # Tunisia
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*turkey[^<]*<END_COUNTRY/BEGIN_COUNTRYTUR<END_COUNTRY/i' <<< "$xmldoc") # Turkey
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*trinidad[^<]*<END_COUNTRY/BEGIN_COUNTRYTTO<END_COUNTRY/i' <<< "$xmldoc") # Trinibad and Tobago
	xmldoc=$(sed 's/BEGIN_COUNTRYgb<END_COUNTRY/BEGIN_COUNTRYUK<END_COUNTRY/i' <<< "$xmldoc") # UK
	xmldoc=$(sed 's/BEGIN_COUNTRYuni[^ ]* \?k[^<]*<END_COUNTRY/BEGIN_COUNTRYUK<END_COUNTRY/i' <<< "$xmldoc") # UK
	xmldoc=$(sed 's/BEGIN_COUNTRYu[\. ]*k[\. ]*<END_COUNTRY/BEGIN_COUNTRYUK<END_COUNTRY/i' <<< "$xmldoc") # UK
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*britain[^<]*<END_COUNTRY/BEGIN_COUNTRYUK<END_COUNTRY/i' <<< "$xmldoc") # UK
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*scotland[^<]*<END_COUNTRY/BEGIN_COUNTRYUK<END_COUNTRY/i' <<< "$xmldoc") # UK
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*ukrai[^<]*<END_COUNTRY/BEGIN_COUNTRYUKR<END_COUNTRY/i' <<< "$xmldoc") # UKR
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*urugua[^<]*<END_COUNTRY/BEGIN_COUNTRYURY<END_COUNTRY/i' <<< "$xmldoc") # Uruguay
	xmldoc=$(sed 's/BEGIN_COUNTRYu[\. ]*s[\. ]*a[\. ]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i' <<< "$xmldoc") # USA
	xmldoc=$(sed 's/BEGIN_COUNTRYusd\?<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i' <<< "$xmldoc") # USA
	xmldoc=$(sed 's/BEGIN_COUNTRYunited sta[^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i' <<< "$xmldoc") # USA
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*[0-9][0-9][0-9][0-9][^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i' <<< "$xmldoc") # USA
	xmldoc=$(sed 's/BEGIN_COUNTRY[^<]*reston[^<]*<END_COUNTRY/BEGIN_COUNTRYUSA<END_COUNTRY/i' <<< "$xmldoc") # USA
	xmldoc=$(sed 's/BEGIN_COUNTRY/<country desc="">/g' <<< "$xmldoc")
	xmldoc=$(sed 's/<END_COUNTRY/<\/country>/g' <<< "$xmldoc")
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

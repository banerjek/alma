barcode="1000065569"

curl -X GET -L -H "Authorization: apikey $(cat apikey.txt)" "https://api-na.hosted.exlibrisgroup.com/almaws/v1/items?item_barcode=$barcode"

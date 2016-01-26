#!/bin/bash

bar="---------------------------------"

echo -n "Enter an email (adam.w.knox@gmail.com): "
read email

# clean the email for urls
if [[ -z "$email" ]]; then
    email="adam.w.knox@gmail.com"
    echo $email
fi
encoded_email=${email//@/%40}


echo $bar #---------------------------------
echo "hgtv.com part1"
url1="https://submit.engagesciences.com/display/form/post?email=$encoded_email&apikey=a587a142-38bd-4a4b-ad68-939d090ab1d1&campaignObjectId=38967&ngx_remember_me=true&ngx_check_entry=true&isXHR=true"

curl -X GET $url1 \
    -H "Accept: application/json, text/javascript, */*; q=0.01" \
    -H "Origin: http://d.engagesciences.com" \
    -H "X-DevTools-Emulate-Network-Conditions-Client-Id: 6A37F6C5-852A-4466-8846-82B9206EFB3B" \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36" \
    -H "Referer: http://d.engagesciences.com/display/container/dc/acfc7003-2445-444c-b942-215ce0345c54/entry?source=hgtv" \
    -H "Accept-Encoding: gzip, deflate, sdch" \
    -H "Accept-Language: en-US,en;q=0.8" \
    -H "Cache-Control: no-cache" #-i # look at the response headers
echo ""



echo $bar #---------------------------------
echo "hgtv.com part2"

# create a tmp form file with this email address
sed "s/\${email}/$email/" <hgtv_form-data.txt >tmp.txt

curl 'https://submit.engagesciences.com/display/form/post' \
    -H 'Origin: http://d.engagesciences.com' \
    -H 'Accept-Encoding: gzip, deflate' \
    -H 'Accept-Language: en-US,en;q=0.8' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36' \
    -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryw7Cg8irjxgULitL0' \
    -H 'Accept: */*' \
    -H 'Referer: http://d.engagesciences.com/display/container/dc/acfc7003-2445-444c-b942-215ce0345c54/entry?source=hgtv' \
    -H 'Connection: keep-alive' \
    --data-binary "@tmp.txt" \
    --compressed #-i # look at the response headers

# cleanup after ourselves
rm tmp.txt
echo ""

#!/bin/bash

#############################################
### Functions
#############################################
function echoHeader {
    # local bar="---------------------------------"

    echo ""
    echo "# "$1
    # echo $bar
}

function submitHgtv {
    echoHeader "hgtv.com part1"

    local url1="https://submit.engagesciences.com/display/form/post?"
    url1+="email=$encoded_email"
    url1+="&apikey=a587a142-38bd-4a4b-ad68-939d090ab1d1"
    url1+="&campaignObjectId=38967"
    url1+="&ngx_remember_me=true"
    url1+="&ngx_check_entry=true"
    url1+="&isXHR=true"

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

    echoHeader "hgtv.com part2"

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
}

function submitDiy {
    echoHeader "diynetwork.com part1"

    local url2="https://submit.engagesciences.com/display/form/post?"
    url2+="email=$encoded_email"
    url2+="&apikey=a587a142-38bd-4a4b-ad68-939d090ab1d1"
    url2+="&campaignObjectId=39333"
    url2+="&ngx_remember_me=true"
    url2+="&ngx_check_entry=true"
    url2+="&isXHR=true"

    curl -X GET $url2 \
        -H 'Pragma: no-cache' \
        -H 'Origin: http://d.engagesciences.com' \
        -H 'Accept-Encoding: gzip, deflate, sdch' \
        -H 'Accept-Language: en-US,en;q=0.8,pt;q=0.6' \
        -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36' \
        -H 'Accept: application/json, text/javascript, */*; q=0.01' \
        -H 'Referer: http://d.engagesciences.com/display/container/dc/d45b9f69-9bce-4b06-96b1-ca8dd831da72/entry?source=diy' \
        -H 'Connection: keep-alive' \
        -H 'Cache-Control: no-cache' \
        --compressed #-i # look at the response headers
    echo ""


    echoHeader "diynetwork.com part2"

    # create a tmp form file with this email address
    sed "s/\${email}/$email/" <diy_form-data.txt >tmp2.txt

    curl 'https://submit.engagesciences.com/display/form/post' \
        -H 'Pragma: no-cache' \
        -H 'Origin: http://d.engagesciences.com' \
        -H 'Accept-Encoding: gzip, deflate' \
        -H 'Accept-Language: en-US,en;q=0.8,pt;q=0.6' \
        -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36' \
        -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryw7Cg8irjxgULitL0' \
        -H 'Accept: */*' \
        -H 'Cache-Control: no-cache' \
        -H 'Referer: http://d.engagesciences.com/display/container/dc/d45b9f69-9bce-4b06-96b1-ca8dd831da72/entry?source=diy' \
        -H 'Connection: keep-alive' \
        --data-binary "@tmp2.txt" \
        --compressed #-i # look at the response headers

    # cleanup after ourselves
    rm tmp2.txt
    echo ""
}

#############################################
### Start
#############################################
echo -n "Enter an email (adam.w.knox@gmail.com): "
read email

# clean the email for urls
if [[ -z "$email" ]]; then
    email="adam.w.knox@gmail.com"
    echo $email
fi
encoded_email=${email//@/%40}

# these implicitly have access to all variables i guess
# god these are ugly
submitHgtv
submitDiy



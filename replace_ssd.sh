#! /bin/bash
# node app is running on windows machine
# http request to search through my email, create new ssd,
# and replace that particular ssd on sakura-resource-zh-TW


# usage : ssd [date]
# ex    : ssd 200601
#         [date] defaults to today


date_=$(date +%y%m%d)
if [[ -z $1 ]];then
  curl -X GET "http://bobewin:3001/replace_ssd?date=${date_}"
else
  curl -X GET "http://bobewin:3001/replace_ssd?date=${1}"
fi 1> /dev/null && echo && echo Done!


while read LINE; do
  search_result=$(find ~/op/sakura-resource-zh-TW/server -name "$LINE")
  if [ $(printf '%s\n' $search_result | wc -l) -gt 1 ]; then
    printf '%s\n' $search_result 
    echo
  else
    echo $search_result is fine
    echo  
  fi
done

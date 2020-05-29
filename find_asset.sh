while read LINE; do
  if [ $(find ~/op/sakura-resource-zh-TW/server -name "$LINE") ]; then
    :
  else
    echo $LINE 
  fi
done

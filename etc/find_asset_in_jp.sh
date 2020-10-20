while read LINE; do
  if [ $(find ~/op/sakura-resource-jp/server -name "$LINE") ]; then
    :
  else
    echo $LINE 
  fi
done

# usage:
# $ cat missing_voices_list.txt | ENV=jp./move_voices.sh 

ENV=${ENV:-"zh-TW"}

while read line
do
  file=$line
  dir_name=$(echo $file | cut -d '_' -f 1)
  to_be_moved=$(find voice -name $file)
  if [ $(find ~/op/sakura-resource-$ENV -name $file) ]; then
    :
  else
    echo $to_be_moved
    mkdir -p ~/op/sakura-resource-$ENV/server/Voice/$dir_name && cp $to_be_moved ~/op/sakura-resource-$ENV/server/Voice/$dir_name
  fi
done

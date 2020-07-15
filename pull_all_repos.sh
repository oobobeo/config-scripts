#! /usr/bin/env bash
# pull all op-related repos

repos=(
sakura-server-1
sakura-server-2
sakura-server-3
sakura-server-4
sakura-archive-all
sakura-resource-zh-TW
sakura-resource-jp
sakura-master-data
sakura-archive-script
yoshino
chiyo
op-local-tools
sakura-client.wiki
)
color='\033[1;34m'
nocolor='\033[0m'
for repo in ${repos[@]}; do
  echo -e "${color}$repo${nocolor}"
done | parallel --plus --will-cite -j10 'dir={}; cd ~/op/${dir:7:-4}; echo $dir; git -c color.status=always pull'
#parallel --will-cite -j10 'cd ~/op/${{}:10:-7}; pwd; git -c color.status=always pull' 
echo 
echo Done! 


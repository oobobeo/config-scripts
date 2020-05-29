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
)
for repo in ${repos[@]}; do
  echo $repo
done | parallel --will-cite -j10 'cd ~/op/{}; pwd; git -c color.status=always pull' 

echo 
echo Done! 


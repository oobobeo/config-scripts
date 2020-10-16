#! /usr/bin/env bash
# pull all op-related repos

repos=(
sakura-server-1
sakura-server-2
sakura-server-3
sakura-server-4
sakura-server-deploy-real
sakura-server-deploy-alpha
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
action=$1
case $action in
  pull)
    color='\033[1;34m'
    nocolor='\033[0m'
    for repo in ${repos[@]}; do
      echo -e "${color}$repo${nocolor}"
    done | parallel --plus --will-cite -j10 'dir={} && cd ~/op/${dir:7:-4} && echo $dir && git -c color.status=always pull'
    ;;
  push)
    color='\033[1;34m'
    nocolor='\033[0m'
    for repo in ${repos[@]}; do
      echo -e "${color}$repo${nocolor}"
    done | parallel --plus --will-cite -j10 'dir={} && cd ~/op/${dir:7:-4} && echo $dir && git -c color.status=always push && git push --tags'
    ;;
  *)
    echo 'usage : ./repos.sh [pull|push]'
    ;;
esac

echo
echo Done!


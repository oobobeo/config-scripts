#! /bin/bash

# GIt Navigate
# navigate git commits relative to HEAD

# usage:
# gn [-b] n : jumps n number of commits towards the latest commit, -b for backwards

set -e

while getopts "b" opt;do
  case $opt in
    b)
      b=true
      ;;
    *)
      echo 'usage: gn [-b] n'
      ;;
  esac
done
shift $((OPTIND-1))
index=$1

if [[ -n $b ]];then
  # to older commits
  git checkout HEAD~$index
else
	# to newer commits
  current_branch=$(git branch --color=never --sort=committerdate | cut -d'*' -f2 | cut -d' ' -f3 | tail -1)
	target=$(git rev-list --ancestry-path HEAD..$current_branch | tail -$index | head -1)
  git checkout $target
fi

# print current commit
#it log --oneline | head -n1
#git이 알아서 해줌

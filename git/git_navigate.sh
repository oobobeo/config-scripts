#! /bin/bash

# GIt Navigate
# navigate git commits relative to HEAD

# usage:
# gn [-b] n : jumps n number of commits towards the latest commit, -b for backwards
while getopts "b" opt;do
  case $opt in
    b)
      b=true
      echo bbbbbb
      ;;
    *)
      echo 'usage: gn [-b] n'
      ;;
  esac
done
shift $((OPTIND-1))
index=$1

echo b $b
if [[ -n $b ]];then
	echo inside if, b = $b
  index=$((-index))
fi

echo aa $index



current_branch=$(git branch --color=never --sort=committerdate | cut -d'*' -f2 | cut -d' ' -f3 | tail -1)
echo $current_branch
echo $1
target=$(git rev-list --ancestry-path HEAD..$current_branch | tail -$1 | head -1)
echo $target

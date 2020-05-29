#! /bin/bash

# substitute for xlsxgrep because that shit doesn't work
# iterate current directory and grep all *.xlsx files
# as slow/fast as grep


# Usage
# (at root dir) $ xlsxgrep OPTION PATTERN [ -d directory ]  


# Options
# [ -r ] recursively search from root dir
# [ -d ] search from specified directory 

dir=$(pwd)
files=
while getopts ":d:rh" arg; do
  case ${arg} in
    d)
      dir=${OPTARG}
      echo $dir
      ;;
    r)
      files=$(find $dir -name '*' | \grep -v './.git*' | \grep 'xlsx$' | tr '\n' ' ')
      echo $*
      ;;
    h)
      echo "usage: xlsxgrep [ -r ] [ -d dir ] expression" 
      exit 1
      ;;
    *)
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

if [[ -z $files ]];then
  cd $dir
  files=$(printf '%s\n' * | \grep -v './.git*' | \grep 'xlsx$' | tr '\n' ' ')
fi

xl='/home/sakura/go/bin/git-xlsx-textconv'
re=$1
files1=(`echo ${files}`);
result=()
for f in "${files1[@]}"
do
  if [[ $(file $f) =~ 'Zip' ]];then 
    temp=$( $xl $f | grep $re )
    if [[ ! -z $temp ]];then
      result+="===========================================\n"
      result+="< $f >\n"
      result+="$temp\n"
      result+="===========================================\n"
    fi
  fi
done

#rintf "%s\n" "$result[@]"
(IFS=$'\n'; echo -e "${result[@]}") # | less -F


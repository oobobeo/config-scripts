#! /bin/bash
DIR=$(pwd)
DIR=$( echo $DIR | rev | cut -d'/' -f'1' | rev ) 

if [[ ! $DIR =~ 'sakura-server' ]]; then
  echo DIRECTORY DOESN\'T APPEAR TO BE A sakura-server repo
  echo run from the root of sakura-server
  echo aliased to \'sandbox\' 
  exit 1
fi

git apply ~/op/config-scripts/patches/to_sandbox.patch && echo DONE!

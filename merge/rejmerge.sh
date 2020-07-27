#!/bin/bash

# cd to directory you want to merge (e.g. app/controller)
# searchs through all *.rejs and opens vi
# `$ rmrej` to delete all *.rej files

rejs=$(find . -name "*.rej")
for rej in ${rejs[@]}; do
  vi -O ${rej:0:-4} $rej
done 

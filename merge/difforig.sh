#!/bin/bash
# usage : difforig [filename]

file=$1
#ile_orig=$(find ~/op/sakura-server-orig -name $file)
#i -O $file $file_orig
vimdiff -O $file ~/op/sakura-server-orig/$file

#! /bin/bash
cd ~/op
echo 'REMOVING  [ cdn, master-data, game ] zip files'
find -maxdepth 1 -name 'master-data-kyoko-default-*' | xargs -I {} rm {} 
find -maxdepth 1 -name 'cdn_diff*.zip' | xargs -I {} rm {} 
find -maxdepth 1 -name 'game-*.zip' | xargs -I {} rm {} 

echo 'REMOVING .DS_Store'
find . -iname '.DS_Store*' | xargs -I {} rm {} 

echo 'REMOVING ._* files'
find .  -iname '._*' | sed 's/\ /\\ /g' | xargs -I {} rm {} 

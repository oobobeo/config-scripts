name=$1
catimg='/usr/local/bin/catimg'
files=$(find . -name $name)
catimg $files
printf '%s\n' $files

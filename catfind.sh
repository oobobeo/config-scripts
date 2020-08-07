name=$1
catimg='/usr/local/bin/catimg'
files=$(find . -name $name)
for file in $files; do
  catimg $file
  printf '%s\n' $file
done;

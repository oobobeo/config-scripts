# oggenc 로 *.wav -> *.ogg 
# oggenc 가 디렉토리명에 유니코드 있으면 변환을 못하는듯.
# 스크립트로 해결한다

# 사용법
# ./wav_to_ogg.sh {dir}



TEMP="$1"
cd "$TEMP"
ROOT=$(pwd)
echo $ROOT

dirs=$(\ls -R | \grep './*:' | cut -c3- | rev | cut -c2- | rev)
for dir in $dirs
do
  cd "$ROOT/$dir" 
  files=$(find . -name '*.wav') 
  for file in $files
  do
   oggenc $file 
  done
done










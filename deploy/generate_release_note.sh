#! /usr/bin/env bash

GAME_FILE=
CDN_FILE=
DB_FILE=

PREV_SERVER_VERSION=
SERVER_VERSION=
SERVER_CHANGELOGS=

PREV_CDN_VERSION=
CDN_VERSION=
CDN_REAL_NTY=
CDN_ALPHA_NTY=
CDN_CHANGELOGS=

PREV_DB_VERSION=
DB_VERSION=
DB_CHANGELOGS=



# begin logic

# setup previous versions
set_previous_versions () {
  cd ~/op/sakura-client.wiki
  num=0
  while [[ -z $PREV_SERVER_VERSION || -z $PREV_CDN_VERSION || -z $PREV_DB_VERSION ]];do
    _date=$(date +%Y-%m-%d -d "$num day ago")
    if [[ -e Release-"$_date".md ]];then
      if [[ -z $PREV_SERVER_VERSION ]];then
        temp=$(grep -e '^# server (tw [[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*)' Release-"$_date".md)
        temp=$(echo $temp | rev | cut -d'#' -f1 | rev)
        PREV_SERVER_VERSION=${temp:12: -1}
      fi
      if [[ -z $PREV_CDN_VERSION ]];then
        temp=$(grep -e '^# cdn (tw [[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*)' Release-"$_date".md)
        temp=$(echo $temp | rev | cut -d'#' -f1 | rev)
        PREV_CDN_VERSION=${temp:9: -1}
      fi
      if [[ -z $PREV_DB_VERSION ]];then
        temp=$(grep -e '^# db (tw [[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*)' Release-"$_date".md)
        temp=$(echo $temp | rev | cut -d'#' -f1 | rev)
        PREV_DB_VERSION=${temp:8: -1}
      fi
    fi
    #cho SERVER $PREV_SERVER_VERSION CDN $PREV_CDN_VERSION DB $PREV_DB_VERSION
    ((num=num+1))
  done
}

# setup variables
# 1. server variables
#SERVER_VERSION="v8.3.test"
#SERVER_CHANGELOGS="aaaa bbbb cccc"
setup_server_variables () {
  cd ~/op/sakura-server-1
  latest_server_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
  if [[ ${PREV_SERVER_VERSION:4} -ge ${latest_server_tag:5} ]];then
    SERVER_VERSION=
    return 1
  fi
  SERVER_VERSION=${latest_server_tag:1}

  # changelogs
  line_num=$(grep -n "## ${PREV_SERVER_VERSION}" CHANGELOG.md | cut -d':' -f1)
  SERVER_CHANGELOGS=$(cat CHANGELOG.md | head -n"${line_num}" | \grep '* ')
}


# 2. cdn variables
setup_cdn_variables () {
  cd ~/op/sakura-archive-all
  latest_cdn_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
  if [[ ${PREV_CDN_VERSION:4} -ge ${latest_cdn_tag:5} ]];then
    CDN_VERSION=
    return 1
  fi
  CDN_VERSION=${latest_cdn_tag:1}

  # archive-all commit timestamp
  t1=$(git show -s --format=%ci v$PREV_CDN_VERSION)
  t2=$(git show -s --format=%ci $latest_cdn_tag)

  # resource commit-messages from archive timestamp
  cd ~/op/sakura-resource-zh-TW
  CDN_CHANGELOGS=$(git log --pretty=short --since="$t1" --until="$t2" | grep '^    ' | sed 's/^    //g')
  echo CCCCCCCCCCC
  echo $(printf "%s" $CDN_CHANGELOGS | grep -e 'TW-????')
  echo '########'
  echo $(printf "%s" $CDN_CHANGELOGS | grep -v -e 'TW-????')

  echo DDDDDDDDDDD

  cd ~/op/sakura-archive-all
  CDN_REAL_NTY=$(git show --name-only v$CDN_VERSION | grep 'REAL.nty' | rev | cut -d'/' -f1 | rev)
  CDN_ALPHA_NTY=$(git show --name-only v$CDN_VERSION | grep 'ALPHA.nty' | rev | cut -d'/' -f1 | rev)
  CDN_ALPHA_ALT_NTY="${CDN_ALPHA_NTY::-9}ALPHA_ALT.nty"
}


# 3. db variables
setup_db_variables () {
  cd ~/op/sakura-master-data
  latest_db_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
  if [[ ${PREV_DB_VERSION:4} -ge ${latest_db_tag:5} ]];then
    DB_VERSION=
    return 1
  fi
  DB_VERSION=${latest_db_tag:1}

  # changelogs
  temp=$(git log v$PREV_DB_VERSION..v$DB_VERSION --pretty=short | grep '^    ' | sed 's/^    //g')
  DB_CHANGELOGS=$temp

}

setup_uploaded_files () {
  if [[ -n $SERVER_VERSION ]];then
    commit_hash=$(git show --color=never --pretty=oneline v$SERVER_VERSION | head -n1 | cut -d' ' -f1)
    GAME_FILE="game-v$SERVER_VERSION-${commit_hash:0:7}.zip"
  fi
  if [[ -n $CDN_VERSION ]];then
    cdn_version_minus_four=$((${CDN_VERSION:4} - 4))
    CDN_FILE="cdn_diff_v${CDN_VERSION:0:4}${cdn_version_minus_four}_v${CDN_VERSION}.zip"
  fi
  if [[ -n $DB_VERSION ]];then
    DB_FILE="master-data-kyoko-default-v${DB_VERSION}.zip"
  fi
}

print_uploaded_files () {
  if [[ -n $GAME_FILE ]];then
    echo '*' "$GAME_FILE"
  fi
  if [[ -n $CDN_FILE ]];then
    echo '*' "$CDN_FILE"
  fi
  if [[ -n $DB_FILE ]];then
    echo '*' "$DB_FILE"
  fi
}

# setup variables
set_previous_versions
echo PREV
echo server $PREV_SERVER_VERSION db $PREV_DB_VERSION cdn $PREV_CDN_VERSION
setup_server_variables
setup_cdn_variables
setup_db_variables
echo CURRENT
echo server $SERVER_VERSION db $DB_VERSION cdn $CDN_VERSION
echo
echo
setup_uploaded_files



SERVER_TEMPLATE="# server (tw ${SERVER_VERSION})
  * Please apply 8.3.x patch to 125.209.245.243 alpha server
  * Please apply 8.3.x patch to real server on maintenance day

## changelogs
$(printf "%s\n" "$SERVER_CHANGELOGS" | while IFS= read -r line; do echo "$line"; done)
"

CDN_TEMPLATE="# cdn (tw ${CDN_VERSION})
* ftp: $(date +%Y%m%d)/cdn_diff_v${CDN_VERSION:0: -4}$(( ${CDN_VERSION: -4} - 4 ))_v${CDN_VERSION}.zip
* list v9 TAIWAN:
  * ALPHA (v9.0.x): "${CDN_ALPHA_NTY}"
  * REAL  (v9.0.x): "${CDN_REAL_NTY}"

## changelogs
$( printf "%s" "$CDN_CHANGELOGS" | xargs -I{} echo '*' '{}')
"

DB_TEMPLATE="# db (tw "${DB_VERSION}")
* Please apply 8.3.x.ALPHA patch to 147.92.157.238 alpha server
* Please apply 8.3.x.REAL  patch to real server on maintenance day

## changelogs
$( printf "%s" "$DB_CHANGELOGS" | xargs -I{} echo '*' '{}')
"

SMALL_SEPARATOR="\n\n---\n\n\n"
BIG_SEPARATOR="\n\n---\n---\n---\n---\n---\n\n\n"



# print out complete release-note
echo '# uploaded files'
print_uploaded_files

printf $BIG_SEPARATOR
if [[ -n $SERVER_VERSION ]];then
  printf "$SERVER_TEMPLATE"
fi

if [[ -n $DB_VERSION ]];then
  if [[ -n $SERVER_VERSION ]];then
    printf $SMALL_SEPARATOR
  fi
  printf "$DB_TEMPLATE"
fi

if [[ -n $CDN_VERSION ]];then
  if [[ -n $SERVER_VERSION || -n $DB_VERSION ]];then
    printf $SMALL_SEPARATOR
  fi
  printf "$CDN_TEMPLATE"
fi














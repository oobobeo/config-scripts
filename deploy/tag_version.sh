#! /usr/bin/env bash
set -e

if [[ ! $(git describe --tags | grep '-') ]];then
  echo HEAD is already tagged
  exit 1
fi

current_version=$(git describe --tags $(git rev-list --tags --max-count=1))
minor=${current_version:5}
next_version=${current_version::5}$(( $minor + 1 ))

echo "${current_version} -> ${next_version}"
git tag ${next_version}

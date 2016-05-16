#!/bin/bash

set -e

user=$(whoami)

function update(){
  sudo chown -R "$user":"$user" *
  rm -f settings.7z

  7z a -p -x\!sss.sh settings.7z *
  rm -rf settings
}

function extract(){
  7z x settings.7z
}

function apply(){
 echo "apply"
}

function show-help(){
  echo 'Call this function with:'
  echo ''
  echo ' extract - to extract the settings to the current directory for modification'
  echo ' update  - to compress the extracted and modified settings'
  echo ' apply   - to apply the compressed settings'
}

# start processing

if [[ $1 == 'update' ]]; then
  update
elif [[ $1 == 'extract' ]]; then
  extract
elif [[ $1 == 'apply' ]]; then
  apply
else
  show-help
fi

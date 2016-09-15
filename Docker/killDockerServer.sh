#!/bin/bash

# This script will remove all running containers and rename all stopped (data
# volume) containers to <oldname>_bak

for c in $(sudo docker ps -q); do
  sudo docker stop $c
  sudo docker rm -v $c
done

for c in $(sudo docker ps -a --format '{{ .Names }}'); do
  sudo docker rename $c ${c}_bak
done

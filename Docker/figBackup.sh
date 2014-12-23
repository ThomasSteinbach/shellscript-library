#!/bin/bash

hostBackupFolderName="figOrchestrationBackup"
hostBackupDir="$(pwd)/$hostBackupFolderName"

function backup_volume(){
  docker run --rm --volumes-from "$1" -v "$hostBackupDir/${1}/${2}":/backup ubuntu tar cf /backup/backup.tar $2
}

function get_volumes() {
  for volume in $(sudo docker inspect "$1" | jshon -e 0 -e "Config" -e "Volumes" -k); do
    backup_volume "$1" "$volume"
  done
}

# read containers from 'fig ps' in fist
# column starting on third line
for container in $(fig ps | tail -n +3 | awk '{print $1}'); do
  get_volumes "${container}"
done

tar czf backup.tar.gz "$hostBackupFolderName"

docker run --rm -v "$(pwd)":"/mnt/share" ubuntu rm -rf /mnt/share/"$hostBackupFolderName"

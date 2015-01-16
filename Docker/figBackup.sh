#!/bin/bash

# $1 - backup / restore
# $2 - workspace Path where fig.yml is located
# $3 - backup dir name in workspace path
# $4 - backup file name

cd "$2"

hostBackupFolderName="figOrchestrationBackup"
hostBackupDir="$(pwd)/$hostBackupFolderName"

function backup_volume(){
  sudo docker run --rm --volumes-from "$1" -v "$hostBackupDir/${1}/${2}":/backup ubuntu tar cf /backup/backup.tar $2
}

function restore_volume(){
  sudo docker run --rm --volumes-from "$1" -v "$hostBackupDir/${1}/${2}":/backup ubuntu tar xf /backup/backup.tar -C /
}

function for_volumes() {
  for volume in $(sudo docker inspect "$2" | jshon -e 0 -e "Config" -e "Volumes" -k); do
    if [ $1 == 'backup' ]; then
      backup_volume "$2" "$volume"
    elif [ $1 == 'restore' ]; then
      restore_volume "$2" "$volume"
    fi
  done
}

# pre-actions
sudo fig stop
if [ $1 == 'restore' ]; then
  # remove old containers and create new clean ones
  sudo fig rm --force
  tar xzf "$3/$4"
  sudo fig up -d
  sudo fig stop
fi

# read containers from first column of 'fig ps'
for container in $(sudo fig ps | tail -n +3 | awk '{print $1}'); do
  for_volumes $1 "${container}"
done

# post-actions
if [ $1 == 'backup' ]; then
    mkdir -p "$3"
    tar czf "$3/$4.tar.gz" "$hostBackupFolderName" fig.yml
    sudo docker run --rm -v "$(pwd)":"/mnt/share" ubuntu rm -rf /mnt/share/"$hostBackupFolderName"
elif [ $1 == 'restore' ]; then
	sudo docker run --rm -v "$(pwd)":"/mnt/share" ubuntu rm -rf /mnt/share/"$hostBackupFolderName"
fi
#!/bin/bash
# see https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups
# see http://tldp.org/HOWTO/LVM-HOWTO/snapshots_backup.html

export BORG_REPO=ssh://${SSH_USER}@${SSH_REMOTE}:${SSH_PORT}/./borgbackup
RETRIES=5

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Creating LVM Snapshot"

lvcreate -l100%FREE -s -n backup /dev/local/openshift

mkdir /tmp/backup
mount /dev/local/backup /tmp/backup


info "Starting backup"

TIMESTAMP=$(date +%Y-%m-%d_%H%M)
backup_exit=999

while [[ $backup_exit -gt 0 && $RETRIES -gt 0 ]]; do
  borg create --verbose \
              --stats \
              --compression auto,zlib,6 \
              ::"${TIMESTAMP} \
              /tmp/backup

  backup_exit=$?
  RETRIES=$((RETRIES-1))
done

info "Pruning repository"

borg prune                          \
    --list                          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

umount /tmp/backup
rmdir /tmp/backup

lvremove /dev/local/openshift

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}

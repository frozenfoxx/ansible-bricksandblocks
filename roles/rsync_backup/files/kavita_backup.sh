#!/usr/bin/env bash

# Backs up a Kavita server

# Variables
BACKUP_DATE=$(/bin/date +%Y-%m-%d)
LOG_PATH=${LOG_PATH:-'/var/log'}
SOURCE_PATH=${SOURCE_PATH:-'/opt/Kavita/config/backups'}
SSHPASS_PATH=${SSHPASS_PATH:-"${HOME}/.sshpass"}
TARGET_HOST=${TARGET_HOST:-''}
TARGET_PATH=${TARGET_PATH:-':NetBackup/kavita_backups'}
TARGET_USER=${TARGET_USER:-'backup'}

# Functions

## Check prerequisite commands
check_requirements()
{
  # Check for rsync
  if ! command -v rsync &> /dev/null; then
    echo "rsync not found!"
    exit 1
  fi

  # Check for sshpass
  if ! command -v sshpass &> /dev/null; then
    echo "sshpass not found!"
    exit 1
  fi
}

## Clean up old backups
cleanup_backup()
{
  cd ${SOURCE_PATH} && ls -tp | grep kavita_backup | grep -v '/$' | tail -n +4 | xargs -I {} rm -- {}
}

## Sync the backup to a target and write a log
sync_backup()
{
  echo "Syncing to ${TARGET_HOST}..."
  rsync -av -e "sshpass -f ${SSHPASS_PATH} ssh" ${SOURCE_PATH}/* ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/ > ${LOG_PATH}/kavita_backup.log
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] kavita_backup.sh [options]"
  echo "  Requirements:"
  echo "    rsync                necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "    sshpass              necessary for backup to hosts without proper SSH key support"
  echo "  Environment Variables:"
  echo "    SOURCE_PATH          file path to use from the source (default: '/opt/Kavita/config/backups')"
  echo "    TARGET_HOST          rsync remote target host (default: '')"
  echo "    TARGET_PATH          file path to use from the target (default: ':NetBackup/kavita_backups')"
  echo "    TARGET_USER          user to connect to the target with (default: 'backup')"
  echo "  Options:"
  echo "    -h | --help          display this usage"
}

# Logic

## Argument parsing
while [[ "$#" > 0 ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
  esac
  shift
done

check_requirements
sync_backup
cleanup_backup
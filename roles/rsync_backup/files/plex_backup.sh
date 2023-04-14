#!/usr/bin/env bash

# Backs up a Plex server

# Variables
BACKUP_DATE=$(/bin/date +%Y-%m-%d)
LOG_PATH=${LOG_PATH:-'/var/log'}
SOURCE_PATH=${SOURCE_PATH:-'/var/lib/plexmediaserver'}
TARGET_HOST=${TARGET_HOST:-''}
TARGET_PATH=${TARGET_PATH:-'/Apps'}
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
}

## Clean up old backups
cleanup_backup()
{
  cd /tmp/ && ls -tp | grep PlexBackup-Metadata | grep -v '/$' | tail -n +4 | xargs -I {} rm -- {}
}

## Create backup file
create_backup()
{
  # Stop Plex
  systemctl stop plexmediaserver.service

  cd ${SOURCE_PATH}
  tar cfz /tmp/PlexBackup-Metadata-${BACKUP_DATE}.tar.gz ./Library

  # Restart Plex
  systemctl start plexmediaserver.service
}

## Sync the backup to a target
sync_backup()
{
  echo "Syncing to ${TARGET_HOST}..."
  rsync -avP /tmp/PlexBackup-Metadata-${BACKUP_DATE}.tar.gz ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/ > ${LOG_PATH}/plex_backup.log
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] plex_backup.sh [options]"
  echo "  Requirements:"
  echo "    rsync                necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE_PATH          file path to use from the source (default: '/var/lib/plexmediaserver')"
  echo "    TARGET_HOST          rsync remote target host (default: '')"
  echo "    TARGET_PATH          file path to use from the target (default: '/Apps')"
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
create_backup
sync_backup
cleanup_backup
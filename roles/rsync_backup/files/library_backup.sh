#!/usr/bin/env bash

# Backs up a Library server

# Variables
LOG_PATH=${LOG_PATH:-'/var/log'}
SOURCE_PATH=${SOURCE_PATH:-'/library'}
TARGET_HOST=${TARGET_HOST:-''}
TARGET_PATH=${TARGET_PATH:-'/library'}
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

## Sync the backup to a target
sync_backup()
{
  echo "Syncing to ${TARGET_HOST}..."
  rsync -avP --delete ${SOURCE_PATH}/Documents/ ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/Documents/ > ${LOG_PATH}/library_documents_backup.log
  rsync -avP --delete ${SOURCE_PATH}/Games/ ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/Games/ > ${LOG_PATH}/library_games_backup.log
  rsync -avP --delete ${SOURCE_PATH}/Music/ ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/Music/ > ${LOG_PATH}/library_music_backup.log
  rsync -avP --delete ${SOURCE_PATH}/Pictures/ ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/Pictures/ > ${LOG_PATH}/library_pictures_backup.log
  rsync -avP --delete ${SOURCE_PATH}/Videos/ ${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/Videos/ > ${LOG_PATH}/library_videos_backup.log
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] library_backup.sh [options]"
  echo "  Requirements:"
  echo "    rsync                necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE_PATH          file path to use from the source (default: '/library')"
  echo "    TARGET_HOST          rsync remote target host (default: '')"
  echo "    TARGET_PATH          file path to use from the target (default: '/library')"
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

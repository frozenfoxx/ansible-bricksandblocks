#!/usr/bin/env bash

# Backs up a Barotrauma server

# Variables
SOURCE=${SOURCE:-'barotrauma'}
SOURCE_PATH=${SOURCE_PATH:-'/home/btserver/serverfiles/'}
TARGET=${TARGET:-''}
TARGET_PATH=${TARGET_PATH:-'/library/Games/Barotrauma/btserver/'}

# Functions

## Check prerequisite commands
check_requirements()
{
  # Check for rclone
  if ! command -v rsync &> /dev/null; then
    echo "rsync not found!"
    exit 1
  fi
}

## Sync the backup to a target
sync_backup()
{
  echo "Syncing from ${SOURCE} to ${TARGET}..."
  rsync -avP --delete ${SOURCE}:${SOURCE_PATH} ${TARGET}:${TARGET_PATH}
}

## Create the backup archive
create_backup()
{
  echo "Creating backup on ${SOURCE}..."
  ssh -o "StrictHostKeyChecking=no" ${SOURCE} sudo -u btserver ./btserver backup
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] barotrauma_backup.sh [options]"
  echo "  Requirements:"
  echo "    rsync                necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE               host housing the Barotrauma deployment (default: 'barotrauma')"
  echo "    SOURCE_PATH          user to connect to the server with (default: '/home/btserver/serverfiles/')"
  echo "    TARGET               rsync remote target (default: '')"
  echo "    TARGET_PATH          rsync remote target path (default: '/library/Games/Barotrauma/btserver/')"
  echo "  Options:"
  echo "    -h | --help          display this usage"
}

# Logic

## Argument parsing
while [[ "$#" > 1 ]]; do
  case $1 in
    -h | --help ) usage
                  exit 0
  esac
  shift
done

check_requirements
create_backup
sync_backup

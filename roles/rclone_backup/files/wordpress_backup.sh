#!/usr/bin/env bash

# Backs up a Wordpress server

# Variables
SOURCE=${SOURCE:-'wordpress'}
SOURCE_PATH=${SOURCE_PATH:-'/var/www/html'}
TARGET=${TARGET:-''}
TARGET_PATH=${TARGET_PATH:-'/wordpress'}

# Functions

## Check prerequisite commands
check_requirements()
{
  # Check for rclone
  if ! command -v rclone &> /dev/null; then
    echo "rclone not found!"
    exit 1
  fi
}

## Clone the backup to a target
clone_backup()
{
  echo "Cloning from ${SOURCE} to ${TARGET}..."
  rclone sync ${SOURCE}:${SOURCE_PATH}/ ${TARGET}:${TARGET_PATH}/$(hostname)/
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] wordpress_backup.sh [options]"
  echo "  Requirements:"
  echo "    rclone               necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE               rclone source target housing the Wordpress server (default: 'wordpress')"
  echo "    SOURCE_PATH          file path to use from the source (default: '/var/www/html')"
  echo "    TARGET               rclone remote target (default: '')"
  echo "    TARGET_PATH          file path to use from the target (default: '/wordpress')"
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
clone_backup

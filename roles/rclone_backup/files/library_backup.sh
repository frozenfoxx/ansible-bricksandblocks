#!/usr/bin/env bash

# Backs up a Library server

# Variables
SOURCE=${SOURCE:-'library'}
SOURCE_PATH=${SOURCE_PATH:-'/library'}
TARGET=${TARGET:-''}
TARGET_PATH=${TARGET_PATH:-'/library'}

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
  rclone sync ${SOURCE}:${SOURCE_PATH}/Documents/ ${TARGET}:${TARGET_PATH}/Documents/
  rclone sync ${SOURCE}:${SOURCE_PATH}/Games/ ${TARGET}:${TARGET_PATH}/Games/
  rclone sync ${SOURCE}:${SOURCE_PATH}/Music/ ${TARGET}:${TARGET_PATH}/Music/
  rclone sync ${SOURCE}:${SOURCE_PATH}/Pictures/ ${TARGET}:${TARGET_PATH}/Pictures/
  rclone sync ${SOURCE}:${SOURCE_PATH}/Videos/ ${TARGET}:${TARGET_PATH}/Videos/
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] library_backup.sh [options]"
  echo "  Requirements:"
  echo "    rclone               necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE               rclone source target housing the Library (default: 'library')"
  echo "    SOURCE_PATH          file path to use from the source (default: '/library')"
  echo "    TARGET               rclone remote target (default: '')"
  echo "    TARGET_PATH          file path to use from the target (default: '/library')"
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

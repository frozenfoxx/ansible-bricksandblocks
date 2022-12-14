#!/usr/bin/env bash

# Backs up a Library server

# Variables
SOURCE=${SOURCE:-'library'}
TARGET=${TARGET:-''}

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
  rclone sync ${SOURCE}:/library/Documents/ ${TARGET}:/Documents/
  rclone sync ${SOURCE}:/library/Games/ ${TARGET}:/Games/
  rclone sync ${SOURCE}:/library/Music/ ${TARGET}:/Music/
  rclone sync ${SOURCE}:/library/Pictures/ ${TARGET}:/Pictures/
  rclone sync ${SOURCE}:/library/Videos/ ${TARGET}:/Videos/
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
  echo "    TARGET               rclone remote target (default: '')"
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

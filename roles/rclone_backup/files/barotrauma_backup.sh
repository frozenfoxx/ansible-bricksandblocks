#!/usr/bin/env bash

# Backs up a Barotrauma server to Linode

# Variables
SOURCE=${SOURCE:-'barotrauma'}
SOURCE_USER=${SOURCE_USER:-'root'}
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

## Clone the backup to Linode

## Create the backup archive
create_backup()
{
}

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] backup2linode_barotrauma.sh [options]"
  echo "  Requirements:"
  echo "    rclone               necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    SOURCE               host housing the Barotrauma deployment (default: 'barotrauma')"
  echo "    SOURCE_USER          user to connect to the server with (default: 'root')"
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
create_backup
clone_backup

#!/usr/bin/env bash

# Backs up a Barotrauma server to Linode

# Variables
DATA_DIR=${DATA_DIR:-'/data'}
SOURCE_HOST=${SOURCE_HOST:-'barotrauma'}
SOURCE_USER=${SOURCE_USER:-'root'}
TARGET=${TARGET:-''}
TARGET_ROOT=${TARGET:-'/backups'}

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

## Display usage information
usage()
{
  echo "Usage: [Environment Variables] backup2linode_barotrauma.sh [options]"
  echo "  Requirements:"
  echo "    rclone               necessary for cloning"
  echo "    ssh                  necessary for remote shell"
  echo "  Environment Variables:"
  echo "    DATA_DIR             data directory for creating the archives (default: '/data')"
  echo "    SOURCE_HOST          host housing the Barotrauma deployment (default: 'barotrauma')"
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

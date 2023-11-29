#!/usr/bin/env bash
#
# Gets the info about a specific Hustle consumer group
#
# Sample usage:
#   kf-check-consumer-group.sh group-name

set -e

if [ -z $1 ]; then
  echo "Missing consumer group name"
  echo "Sample usage: $0 group-name"
  exit 1
fi

kafka-consumer-groups.sh --bootstrap-server kafka.hstl.io:9092 --group $1 --describe

#!/bin/bash

# Check if a service name is provided
if [[ -z "$1" ]]; then
  echo "Error: Please provide the name of the service."
  exit 1
fi

# Check the status of the specified service
status=$(systemctl is-active --quiet "$1" && echo "running" || echo "not running")

# Output the result
echo "The service '$1' is $status."

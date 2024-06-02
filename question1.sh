#!/bin/bash

# Check if log file exists and is readable
if [[ ! -f "$1" || ! -r "$1" ]]; then
  echo "Error: Log file '$1' does not exist or is not readable."
  exit 1
fi

# Total requests count excluding blank lines
total_requests=$(grep -cv '^\s*$' "$1")

## Initialize successful requests count
successful_requests=0

while IFS= read -r line || [ -n "$line" ]; do
  if [[ $line =~ [[:space:]]2[0-9]{2}[[:space:]] ]]; then
    ((successful_requests++))
  fi
done < "$1"

# Percentage of successful requests
success_percentage=$(( (successful_requests * 100) / total_requests ))

# Most active user
most_active_user=$(awk '{print $1}' "$1" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Output the results
echo "Total Requests: $total_requests"
echo "Successful Requests: $successful_requests"
echo "Percentage of Successful Requests: $success_percentage%"
echo "Most Active User: $most_active_user"

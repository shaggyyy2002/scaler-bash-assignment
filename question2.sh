#!/bin/bash

# Check if a directory is provided and if it exists
if [[ -z "$1" || ! -d "$1" ]]; then
  echo "Error: Please provide a valid directory."
  exit 1
fi

# Initialize an associative array to hold the counts of file types
declare -A file_types

# Traverse the specified directory recursively
while IFS= read -r -d '' file; do
  extension="${file##*.}"
  extension="${extension,,}"
  ((file_types["$extension"]++))
done < <(find "$1" -type f -print0)

# Output the results in a sorted list
for extension in "${!file_types[@]}"; do
  echo "$extension: ${file_types[$extension]}"
done | sort

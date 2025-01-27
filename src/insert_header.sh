#!/usr/bin/env bash
#
# insert_header.sh
#
# Inserts header content at the beginning of specified files.
# Usage examples:
#   ./insert_header.sh src/standard_header_en.md "EN_en/*.md"
#   ./insert_header.sh src/standard_header_en.md EN_en/001_Manifesto.md EN_en/002_Article.md
# 
# WARNING: this script directly modifies original files.
# Make sure you have a backup or Git commit before proceeding.

header_file="$1"
shift  # Remove first argument so $@ contains only target files
files=("$@")

# Check parameters
if [ -z "$header_file" ] || [ ${#files[@]} -eq 0 ]; then
  echo "Usage: $0 <header_file> [files...]"
  exit 1
fi

# Check if header file exists
if [ ! -f "$header_file" ]; then
  echo "Header file not found: $header_file"
  exit 1
fi

# Process each specified file
for target_file in "${files[@]}"; do
  # Check if it's a valid file and not the header file itself
  if [ -f "$target_file" ] && [ "$target_file" != "$header_file" ]; then
    # Create temporary file
    temp_file="$(mktemp)"

    # Concatenate header + original content
    cat "$header_file" "$target_file" > "$temp_file"

    # Replace target file with new version
    mv "$temp_file" "$target_file"

    echo "Header inserted in: $target_file"
  fi
done 
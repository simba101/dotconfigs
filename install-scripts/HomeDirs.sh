#!/bin/bash

BOOKMARKS_FILE="$HOME/.config/gtk-3.0/bookmarks"

# Declares an array variable holding the names of the directories in ~:
declare -a DIRS=("IN" "Archived" "Audio" "Builds" "Documents" "Learning"
    "Pictures" "Private" "Repos" "Source" "Tools" "Videos" "VMs" "OUT")

# Removes the bookmarks file if it already exists:
if [ -e "$BOOKMARKS_FILE" ]; then
  printf "Detected existing bookmarks file. Deleting...\n"
  rm "$BOOKMARKS_FILE"
fi

# Creates the directories and entries in the new bookmarks file:
for dir in "${DIRS[@]}"; do
  printf "Processing the directory: ~/%s...\n" "$dir"
  mkdir -p "$HOME/$dir"
  printf "file://%s/%s %s\n" "$HOME" "$dir" "$dir" >> "$BOOKMARKS_FILE"
done

# Creates some more dirs:
mkdir -p "$HOME/Audio/Music"

printf "Successfully completed!\n"

#!/bin/bash
# find all files in current directory with .sh extension
git config core.fileMode false

FILENAMES="$(find . -regex ".*\.\(sh\)")"
for FILENAME in ${FILENAMES}; do
  echo "$0 - Granting execute permission to $FILENAME..."
  chmod +x $FILENAME
done
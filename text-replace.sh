#!/bin/bash
# This script recursively replaces given text with another text in specified files
# Arguments
# $1 - directory to be processed
# $2 - wildcard for matching files (e.g. "*.java")
# $3 - text to be replaced
# $4 - text that will be used instead
# Example: ./text-replace.sh /path/to/project "*.java" "import my.old.package" "import my.new.package"
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

OLD_TEXT=$3
NEW_TEXT=$4

echo "--> Replacing text in files, please wait..."
for FILE in `find $1 -name "$2"`
do
  echo "-> Processing file $FILE"
  sed -i "s/$OLD_TEXT/$NEW_TEXT/g" $FILE
done
echo "--> Finished"

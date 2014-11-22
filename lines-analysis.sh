#!/bin/bash
# This script analyzes how many lines have specific files in given directory.
# You can use this script to analyze source files of any project and find potentional targets for refactoring
# Arguments
# $1 - directory to be searched
# $2 - wildcard for matching files (e.g. "*.java")
# $3 - minimal limit to filter only files with given count of lines or higher#
# Example: ./lines-analysis.sh /path/to/project "*.java" 500
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

FILES_COUNT=0
MATCHING_FILES_COUNT=0

echo "--> Analyzing files, please wait..."
for FILE in `find $1 -name "$2"`
do
  LINES_COUNT=`cat $FILE | wc -l`
  if [ "$LINES_COUNT" -gt "$3" ]; then
    echo "$FILE: $LINES_COUNT"
    MATCHING_FILES_COUNT=`expr $MATCHING_FILES_COUNT + 1`
  fi  
  FILES_COUNT=`expr $FILES_COUNT + 1`
done

PERCENTS=`echo "$MATCHING_FILES_COUNT" "$FILES_COUNT" | awk '{print $1 * 100 / $2}'`
echo "-------------------------------"
echo "Analysis results for: $1 ($2)"
echo "Found $MATCHING_FILES_COUNT files ($PERCENTS% from $FILES_COUNT files)"

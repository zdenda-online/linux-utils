#!/bin/bash
# This script searches the files in directory (first arg) which match specified wildcard (second arg).
# Third arg is the limit of lines count for files which should be printed (added to analysis).
#
# E.g. ./lines-analysis.sh /path/to/project "*.java" 500
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

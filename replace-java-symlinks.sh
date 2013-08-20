#!/bin/bash
# This script iterates all symlinks in the BIN_DIR directory that have the same JDK path as 'java'
# and replaces every symlink with a new one that has the JDK path set from the first script argument.
#
# Useful if you want to switch symlinks from OpenJDK to any other JDK.
# E.g. ./replace-java-symlinks.sh /opt/java6
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

BIN_DIR=/usr/bin

if [[ $EUID -ne 0 ]]; then
  echo "You must be root to run this script"
  exit
fi

if [[ -z "$1" ]]; then
  echo "Pass the new JDK home as the first argument, e.g. /opt/java6"
  exit
fi

ACTUAl_JDK_PATH=`ls -l $BIN_DIR/java | awk '{print $11}' | sed 's:\/jre\/bin\/java::g'`
echo "=> Actual JDK path used by symlinks is: $ACTUAl_JDK_PATH"

NEW_JDK_PATH=`echo ${1%/}` # remove last slash if needed
echo "=> New JDK path for symlinks will be: $NEW_JDK_PATH"

read -p "Are suggested JDK paths correct? (y/n) " yn
if [ "$yn" != "y" ]; then
  echo "Cancelled on user's request"
  exit
fi

echo "----------------------------------------------"

FILES=`ls -l $BIN_DIR | grep $ACTUAl_JDK_PATH`

ls -l $BIN_DIR | grep $ACTUAl_JDK_PATH | while read file;
do
  FILENAME=`echo $file | awk '{print $9}'`
  SYMLINK=`echo $file | awk '{print $11}'`
  
  ACT=`echo $ACTUAl_JDK_PATH | sed 's:\/:\\\/:g'` # escape characters for SED
  NEW=`echo $NEW_JDK_PATH | sed 's:\/:\\\/:g'` # escape characters for SED
  
  NEWLINK=`echo $SYMLINK | sed "s/$ACT/$NEW/g"`
  
  if [ -f $NEWLINK ]; then
    echo "-> Replacing symlink: $BIN_DIR/$FILENAME -> $NEWLINK"
    rm $BIN_DIR/$FILENAME
    ln -s  $NEWLINK $BIN_DIR/$FILENAME    
  else
    echo "!! File $NEWLINK does not exist, skipping symlink re-creation"
  fi
  
done

#!/bin/bash
# This script performs specified git operation over all subdirecties if the subdirectory is GIT repository.
# Arguments
# $1 - command to performed
# Example: ./git-batch.sh status
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

DIR=`pwd`

for REPO in $DIR/*; do
  if [ -d "$REPO" ] && [ -d "$REPO/.git" ]; then
    REPONAME=`basename $REPO`
    echo "--> $REPO is a GIT repository, performing git $1"
    cd $REPO
    git "$1"
    cd $DIR
  fi
done

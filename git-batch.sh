#!/bin/bash
# This script iterates subdirectories in directory from which is executed
# and applies given GIT command to this subdirectory if it is GIT repository.
#
# E.g. ./git-batch.sh status
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

DIR=`pwd`

for REPO in $DIR/*; do
  if [ -d "$REPO" ] && [ -d "$REPO/.git" ]; then
    REPONAME=`basename $REPO`
    echo "--> Repository $REPONAME"
    cd $REPO
    git "$1"
    cd $DIR
  fi
done

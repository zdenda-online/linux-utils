#!/bin/bash
# This script iterates all *.m4a files in working directory and converts them to MP3 audio format.

for a in *.m4a; do
  faad -o - "$a" | lame - "${a%.m4a}.mp3"
done


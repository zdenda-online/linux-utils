#!/bin/bash
# This script iterates all *.flac files in working directory and converts them to MP3 audio format.

for a in *.flac; do
  ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
done

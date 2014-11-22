#!/bin/bash
# This simple script that colors up the logs (typically java logs). 
# It uses tail as the primary tool. You can pass arguments in the same manner as for tail.
# Example #1: ./logs-tail.sh -F /home/xyz/mylog.txt (monitoring file with follow)
# Example #2: ./logs-tail.sh -20 /home/xyz/mylog.txt (last 20 lines)
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

CWD=`dirname $0`

RED="\033[0;91m"
GREEN="\033[0;92m"
YELLOW="\033[0;93m"
BLUE="\033[0;94m"
MAGENT="\033[0;95m"
CYAN="\033[0;96m"
WHITE="\033[0;97m"
GRAY="\033[0;37m"

# include any other colors in this associative array (index = regex pattern)
declare -A color
color["FATAL"]=$RED
color["ERROR"]=$RED
color["SEVERE"]=$RED
#color["Caused by:"]=$RED
#color["at"]=$RED
color["WARN"]=$YELLOW
color["INFO"]=$WHITE
color["DEBUG"]=$GRAY
color["TRACE"]=$GRAY
color["FINE"]=$GRAY
color["FINER"]=$GRAY
color["FINEST"]=$GRAY

AWK_EXPR=""
for i in "${!color[@]}"; do  
  AWK_EXPR="$AWK_EXPR /\s+$i\s+/ { print \"${color[$i]}\" \$0; next }"
done
AWK_EXPR="$AWK_EXPR / / { print \$0; }" # if no match found, do NOT change color

tail "$@" | awk "$AWK_EXPR"
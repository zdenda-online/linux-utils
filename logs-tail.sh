#!/bin/bash
# This simple script that colors up the logs (typically java logs). 
# It uses tail as the primary tool. You can pass arguments in the same manner as for tail.
# E.g. 	./logs-tail.sh -F /home/xyz/mylog.txt (monitoring file with follow)
# or 	./logs-tail.sh -20 /home/xyz/mylog.txt (last 20 lines)
#
# author: Zdenek Obst, zdenek.obst-at-gmail.com

CWD=`dirname $0`

# include any other patterns with colors in this associative array
declare -A color
color[" FATAL "]="\033[0;91m" 	# red
color[" ERROR "]="\033[0;91m" 	# red
color[" SEVERE "]="\033[0;91m"
color[" WARN "]="\033[0;93m" 	# yellow
color[" INFO "]="\033[0;97m" 	# white
color[" DEBUG "]="\033[0;92m" 	# green
color[" FINE "]="\033[0;92m"
color[" TRACE "]="\033[0;94m" 	# light blue
color[" FINER "]="\033[0;94m"
color[" FINEST "]="\033[0;94m" 

AWK_EXPR=""
for i in "${!color[@]}"; do
  AWK_EXPR="/$i/ {print \"${color[$i]}\" \$0 \"\033[39m\"} $AWK_EXPR"
done

tail "$@" | awk "$AWK_EXPR"
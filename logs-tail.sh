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
color["FATAL"]="\033[1;91m" 	# red
color["ERROR"]="\033[1;91m"
color["SEVERE"]="\033[1;91m"
#color["Caused by:"]="\033[1;91m"
#color["at"]="\033[1;91m"

color["WARN"]="\033[1;93m" 	# yellow

color["INFO"]="\033[1;97m" 	# white

color["DEBUG"]="\033[1;92m" 	# green
color["FINE"]="\033[1;92m"

color["TRACE"]="\033[1;94m" 	# light blue
color["FINER"]="\033[1;94m"
color["FINEST"]="\033[1;94m" 

AWK_EXPR=""
for i in "${!color[@]}"; do  
  AWK_EXPR="$AWK_EXPR /\s+$i\s+/ { print \"${color[$i]}\" \$0; next }"
done
AWK_EXPR="$AWK_EXPR / / { print \$0; }"

tail "$@" | awk "$AWK_EXPR"
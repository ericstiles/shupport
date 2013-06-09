#!/bin/sh

####################
#                  #
#  STATIC VARIABLE #
#                  #
####################

# Character separator value
C="="

##################
#                #
#  FUNCTIONS     #
#                #
##################

function explain(){
  echo "##################################################"
  echo "#                                                #"
  echo "# Aggregate all Endeca logs to a single output   #"
  echo "# stream that have been touched since a given    #"
  echo "# time period.  Can > the stream to a file.      #"
  echo "#                                                #"
  echo "# Usage:                                         #"
  echo "#    ./captureLogs.sh [directory] [time(minutes] #"
  echo "#    [number of lines to tail]                   #"
  echo "#                                                #"
  echo "# -d directory is a recursive search             #"
  echo "# -m follows standard find logic                 #"
  echo "# -n number of lines to tail                     #"
  echo "# -h help                                        #"
  echo "#                                                #"
  echo "#                                                #"
  echo "#                                                #"
  echo "#                                                #"
  echo "##################################################"
}
 
# Create separtor line.
# TODO: RETURN SEPARATOR IS VALUE IS ALREADY SET.
function separator (){
  SEPARATOR=""
  i=1
  LENGTH=50
  if [ ! -z "$1" ]; then
    LENGTH=$1
  fi
  while [ "$i" -le "$LENGTH" ]
  do
    SEPARATOR=$SEPARATOR$C
    i=$(($i + 1));
  done
  echo $SEPARATOR
}
 
######################
#                    #
#  ARGUMENT SETUP    #
#                    #
######################
 
# Check arguments exist
if [ "-h" = "$1" -o "$#" = 0 ]; then
explain;
exit 0;
fi
 
# TODO: USE STANDARD LINUX APPROACH FOR IDENTIFYING ARGUMENTS
 
#$1 - directory to search
#$2 - time in minutes to check for file changes
MIN="$2"
 
#$3 - number of lines of tailed file
TAIL="$3"

#$4 - only show files changes
ONLY_SHOW_FILES="$4"
 
######################
#                    #
#   RUN CODE         #
#                    #
######################
 
FILES=$( find $DIR -mmin $MIN \( -iname "*log*.*" -or -iname "*.log" -or -iname "*.out" \) -and ! -iname "*.dat" -and ! -iname "*.lck" -and ! -iname "*.ctrl" -and ! -iname "*.jar" );
 
separator;
echo "--> BEGINING AGGREGATION <--";
separator;
 
for i in $FILES
do
  echo $i
done
separator;

if [[ -z "$ONLY_SHOW_FILES" || "$ONLY_SHOW_FILES" != '-f' ]]; then
  for i in $FILES
  do
    echo $i
    tail -n$3 $i
    echo " "
    separator;
  done
fi

#!/bin/bash
# vim: ai et sts=4 sw=4

# small library to handle colorized logging with log levels

# set to true to see debug messages. defaults to false
TRACE=${TRACE:-"false"}

# import the colors library so we can get colorized messages
source ./colors.sh

# color codes for log messages
ERROR_CODON="$__B_RED"
DEBUG_CODON="$__B_CYAN"
WARN_CODON="$__B_YELLOW"
STOP_CODON="$__RESET_TEXT"

# define some directories
#readonly LOG_HOME="${LOG_HOME:-/appl/ecomm/log}"
#readonly ROTATE_HOME="${ROTATE_HOME:-/appl/ecomm/rotated}"

# show message if $TRACE is true
function debug () {
    if [ $TRACE == true ] && [ $# -gt 0 ]; then
        echo -e "$DEBUG_CODON[DEBUG] $*$STOP_CODON"
    fi
}

#function error () {
#    if [ $# -gt 0 ]; then
#        echo -e "$ERROR_CODON[ERROR] $*$STOP_CODON" >&2
#    fi
#}

#function warn () {
#    if [ $# -gt 0 ]; then
#        echo -e "$WARN_CODON[WARN]  $*$STOP_CODON"
#    fi
#}

#function info () {
#    if [ $# -gt 0 ]; then
#        echo -e "[INFO]  $*$STOP_CODON"
#    fi
#}

#function die_with_code () {
    # validate that the error code is a number between 0 and 256
#    if [[ $1 =~ ^[0-9]+$ ]]; then
#        local code=$1

        # if it's out of range, default to 1
#        [ $code -gt 255 ] && local code=1
#        shift 1
#    else
        # or if we didn't detect a number, then default to 1
#        local code=1
#    fi

    # display error message, and exit with return code
#    error "$*"
#    exit $code
#}

# fail script with optional message
#function die () {
#    die_with_code 1 "$*"
#}

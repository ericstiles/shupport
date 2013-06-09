#!/bin/bash
# vim: ai et sts=4 sw=4

# colors library: provides human-readable color codes

declare -a __BASE_COLORS=("BLACK" "RED" "GREEN" "YELLOW" "BLUE" "MAGENTA" "CYAN" "WHITE")

# remove all attributes
# if buggy, consider using `tput op` or `tput oc`? do a "man terminfo" for details
__RESET_TEXT=`tput sgr0`

# make text bold
__BOLD=`tput bold`

# make text standout - something like reverse video. happens to make bg brighter,
# and invert text color.
__STANDOUT=`tput smso`

# synonym for bold, since some terminals render the same code as either
__BRIGHT=$__BOLD

# internal helper function to create constants representing each variation
# of the color code we want to defines
function __set_colors_for_code () {
    local basename="${__BASE_COLORS[$i]}"
    local colorname="__$basename"
    local brightname="__B_$basename"
    local colornamebg="${colorname}_BG"
    local brightnamebg="${brightname}_BG"

    # set standard foreground
    eval "$colorname=`tput setaf $i`"

    # set bright foreground
    eval "$brightname=$__BRIGHT\$$colorname"

    # set standard background
    eval "$colornamebg=`tput setab $i`"

    # set bright background
    eval "$brightnamebg=$__STANDOUT\$$brightname"
}

# create readable variables for the color codes based on the color name array
# above and the name's index within the array. this means that you shouldn't
# alter the order of the elements, as the indexes are used to derive the color
# codes themselves.
#
# standard foreground color      __COLORNAME
# bright foreground color:       __B_COLORNAME
# standard background color:     __COLORNAME_BG
# bright background color:       __B_COLORNAME_BG (this isn't quite like the ansi seq, uses "standout")
#
# I'm lazy, why type all the color codes manually? :)
for i in {0..7}; do
    __set_colors_for_code $i
done

function test_colors() {
    echo "Testing colors..."
    for i in {0..7}; do
        local basename="${__BASE_COLORS[$i]}"
        local colorname="__$basename"
        local brightname="__B_$basename"
        local colornamebg="${colorname}_BG"
        local brightnamebg="${brightname}_BG"

        eval "local color=\$$colorname"
        echo "$colorname is ${color}this color$__RESET_TEXT"

        eval "local color=\$$brightname"
        echo "$brightname is ${color}this color$__RESET_TEXT"

        eval "local color=\$$colornamebg"
        echo "$colornamebg is ${color}this color$__RESET_TEXT"

        eval "local color=\$$brightnamebg"
        echo "$brightnamebg is ${color}this color$__RESET_TEXT"
    done
}

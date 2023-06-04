#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is printf comment
# Version: 1.1

PRINT_COUNT=5  # num of char(`-`)




function m_printf() {
    if [ $# -ne 1 ]; then
        echo "The function does not have 1 argument."
    fi
    arg1=$1
    num=$PRINT_COUNT  

    line=""
    for ((i=1; i<=num; i++))
    do
        line+="-"
    done

    # prints the leading - character
    printf '%s' $line
    # printf " Current function name: %s " "$FUNCNAME"
    printf " Current function name: %s " "$arg1"
    # prints the postset - character
    printf '%s\n' "$line"
    # printf "%-${num}s\n" "-" | tr ' ' '-'
}



# m_printf "f1231"




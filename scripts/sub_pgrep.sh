#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is check whether the process is running
# Version: 1.1

. ./sub_printf.sh

function grep_process() {
    m_printf $FUNCNAME
    if [ $# -ne 1 ]; then
        echo "args errors!"
        return -1
    fi

    if command -v sudo >/dev/null 2>&1; then
        pgrep $1
        return $?
    fi
}


# grep_process init
# grep_process sh
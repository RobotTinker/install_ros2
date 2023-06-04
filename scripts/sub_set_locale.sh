#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is set locale
# Version: 1.1

. ./sub_printf.sh

function set_locale() {
    m_printf "$FUNCNAME"

    # Set locale
    locale # check for UTF-8
    sudo apt-get update >/dev/null
    sudo apt-get install locales -y >/dev/null
    sudo locale-gen en_US en_US.UTF-8 >/dev/null
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 >/dev/null
    export LANG=en_US.UTF-8
    locale  # 
}














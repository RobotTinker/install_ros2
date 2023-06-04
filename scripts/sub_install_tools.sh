#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is install generic tools
# Version: 1.1

. ./sub_printf.sh


function install_tools() {
    m_printf "$FUNCNAME"
    sudo apt-get update >/dev/null
    sudo apt-get install apt-utils -y >/dev/null
    sudo apt-get install git -y >/dev/null
    sudo apt-get install iputils-ping -y >/dev/null
    sudo apt-get install net-tools -y >/dev/null
    sudo apt-get install curl wget vim -y >/dev/null
}


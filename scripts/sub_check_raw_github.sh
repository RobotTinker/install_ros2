#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is determine whether to visit https://raw.githubusercontent.com
# Version: 1.1

. ./sub_printf.sh

# define enum variables
enum_sucess=0
enum_fail=1
enum_conn_fail=2


echo "+++++++++++++++++++++++++"
function access_raw_github() {
    m_printf $FUNCNAME
    url="https://raw.githubusercontent.com/ros/rosdistro/master/ros.key"
    output_file="ros.key"

    if wget -q --spider "$url"; then
        wget -q "$url" -O "$output_file"
        if [[ $? -eq 0 ]]; then
            echo "ros.key downloaded successfully"
            return $enum_sucess  # success
        else
            echo "Failed to download ros.key"
            return $enum_fail  # fail
        fi
    else
        echo "Failed to connect to the server"
        return $enum_conn_fail  # failed to connect to the server
    fi
}

# access_raw_github
# return_value=$?
# # echo "return_value=$return_value"

# if [[ $return_value == 0 ]]; then
#     echo "function execution succeeds"
# elif [[ $return_value == 1 ]]; then
#     echo "function execution failure"
# elif [[ $return_value == 2 ]]; then
#     echo "failed to connect to the server"    
# fi

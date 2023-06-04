#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is remove ros2
# Version: 1.1

. ./config.sh

. ./sub_apt_install_sudo.sh
install_sudo

sudo apt-get remove ~nros-$ROS_DISTRO-* -y && sudo apt-get autoremove -y

# remove ros2 sources list
sudo rm /etc/apt/sources.list.d/ros2.list
sudo apt-get update
sudo apt-get autoremove -y
#!/bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is install sudo
# Version: 1.1

. ./sub_printf.sh

function install_sudo() {
    m_printf "$FUNCNAME"
    # Check if sudo command exists
    if ! command -v sudo >/dev/null 2>&1; then
        # Install sudo
        if command -v apt-get >/dev/null 2>&1; then
            # Debian/Ubuntu
            echo "Installing sudo..."
            su -c "apt-get update && apt-get install -y sudo"
        elif command -v yum >/dev/null 2>&1; then
            # CentOS/RHEL
            echo "Installing sudo..."
            su -c "yum install -y sudo"
        else
            echo "Error: Unable to install sudo. Package manager not found."
            exit 1
        fi
    fi

    # Add the current user to the sudo group
    if command -v usermod >/dev/null 2>&1; then
        echo "Adding the current user to the sudo group..."
        su -c "usermod -aG sudo $(whoami)"
    fi

    # Verify that sudo is installed
    if ! command -v sudo >/dev/null 2>&1; then
        echo "Error: Failed to install sudo."
        exit 1
    fi

    echo "sudo has been installed successfully."

}

# install_sudo

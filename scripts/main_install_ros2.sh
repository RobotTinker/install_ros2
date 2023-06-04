#! /bin/bash
# Date: 12:48 2023-06-04
# Description: This scripts function is install ros2
# Version: 1.1

. ./config.sh
. ./sub_printf.sh


# ----------- https://www.ncnynl.com/archives/202207/5330.html -----------------------
function update_apt_sources_ncnynl() {
    # update apt sources
    rm superupdate.sh ; wget https://gitee.com/ncnynl/linux-scripts/raw/master/superupdate.sh ; sudo chmod +x ./superupdate.sh; sudo ./superupdate.sh aliyun
}

function add_ros2_gpg_key_with_apt_nynl() {
    # add gpg key and download key
    sudo apt-get update >/dev/null && sudo apt-get install curl gnupg lsb-release -y >/dev/null
    sudo curl -sSL https://mirrors.tuna.tsinghua.edu.cn/rosdistro/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
}

function add_repos_to_sources_list_nynl() {
    # add ros2 sources to sources list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] https://mirrors.tuna.tsinghua.edu.cn/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
}


function install_ros2_packages_nynl() {
    # update apt sources list
    sudo apt-get update >/dev/null
    # install ros2 desktop
    sudo apt-get install ros-$ROS_DISTRO-desktop -y
    # loading env
    source /opt/ros/$ROS_DISTRO/setup.bash
    # install automatic completion
    sudo apt-get install python3-argcomplete -y
    # install colcon and pip
    sudo apt-get install python3-pip -y
    sudo apt-get install python3-colcon-common-extensions -y
}


# ------------   https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html  ----------------------
function update_apt_sources() {
    sudo apt-get install software-properties-common -y >/dev/null
    sudo add-apt-repository universe -y >/dev/null
}

function add_ros2_gpg_key_with_apt() {
    sudo apt-get update >/dev/null
    sudo apt-get install curl -y >/dev/null
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg >/dev/null

}

function add_repos_to_sources_list() {

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
}

function install_ros2_packages() {
    m_printf "$FUNCNAME"
    # Install ROS 2 packages
    echo "----------------------Install ROS 2 packages----------------------"

    sudo apt-get update >/dev/null

    sudo apt-get upgrade >/dev/null

    echo "----------------------install ros-$ROS_DISTRO-desktop----------------------"
    sudo apt-get install ros-$ROS_DISTRO-desktop -y

    echo "----------------------install ros-$ROS_DISTRO-ros-base----------------------"
    sudo apt-get install ros-$ROS_DISTRO-ros-base -y

    echo "----------------------install ros-dev-tools----------------------"
    sudo apt-get install ros-dev-tools -y

    echo "----------------------install done----------------------"
}


function check_ros2() {
    echo "ROS_DISTRO=$ROS_DISTRO"
    echo "/opt/ros/$ROS_DISTRO/"
    if [ -d "/opt/ros/$ROS_DISTRO/" ]; then
        echo "ROS2 installed"
        return 0
    else
        echo "ROS2 not installed"
        return 1
    fi
}

function test_ros2() {
    # run publish topic
    if [ ! -f "/opt/ros/$ROS_DISTRO/setup.bash" ]; then
        return 1
    fi
    source /opt/ros/$ROS_DISTRO/setup.bash
    ros2 run demo_nodes_cpp talker &
    sleep 5
    . ./sub_pgrep.sh
    grep_process "talker"
    result=$?
    if [[ $result==0 ]]; then
        pkill "talker"
        result=$?
        if [[ $result==0 ]]; then    
            echo "install ROS2 success!!!"
            return 0
        fi
    fi

    return 2
}

# check whether ros2 is installed
check_ros2
result=$?
if [ $result == 0 ]; then
    echo "ros2 already installed, exit!!!"
    exit 0
fi

. ./sub_install_sudo.sh
install_sudo

. ./sub_install_tools.sh
install_tools

. ./sub_set_locale.sh
set_locale


# check whether raw.github is accessible
. ./sub_check_raw_github.sh
access_raw_github
return_value=$?
echo "return_value=$return_value"
if [[ $return_value == 0 ]]; then
    echo "success"
    update_apt_sources
    add_ros2_gpg_key_with_apt
    add_repos_to_sources_list
    install_ros2_packages
elif [[ $return_value == 1 ]]; then
    echo "failed"
elif [[ $return_value == 2 ]]; then
    echo "can not connect to https://raw.githubusercontent.com server"   
    update_apt_sources_ncnynl
    add_ros2_gpg_key_with_apt_nynl
    add_repos_to_sources_list_nynl
    install_ros2_packages_nynl
else
    echo "unknown"    
fi

test_ros2




















































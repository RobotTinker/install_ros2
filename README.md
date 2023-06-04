# install_ros2
install ros2 bash scripts

## config.sh
```
ROS_DISTRO="humble"
```

## usage

### install ros2
```
cd scripts
./main_install_ros2.sh 
```

### remove ros2
```
cd scripts
./main_remove_ros2.sh 
```



## next step
support for other version, for example: foxy


## build images


```
cp Dockerfile ..

cd ..

docker run -it my_ubuntu_22.04:v1 /bin/bash


docker login

docker tag my_ubuntu_22.04:v1 dockerfree2023/ubuntu_22.04_ros2_humble:v1
docker push dockerfree2023/ubuntu_22.04_ros2_humble:v1
docker pull dockerfree2023/ubuntu_22.04_ros2_humble:v1
```








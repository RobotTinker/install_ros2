FROM ubuntu:22.04
# 设置 debconf 前端为非交互模式
# ENV DEBIAN_FRONTEND=noninteractive
# ENV TIME_ZONE Asia/Shanghai

# https://juejin.cn/post/7082670118257295391
ENV TZ=Asia/Shanghai 
RUN echo "${TZ}" > /etc/timezone \ 
&& ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \ 
&& apt update \ 
&& apt install -y tzdata \ 
&& rm -rf /var/lib/apt/lists/*

# 更新软件包列表并安装所需的软件包
# RUN apt-get update && apt-get install -y package1 package2
RUN apt-get update 


# 可选：设置环境变量或执行其他定制操作

# 创建文件夹
RUN mkdir -p /install_ros2/scripts

# 复制脚本文件到镜像中
# When using COPY with more than one source file, the destination must be a directory and end with a /
COPY install_ros2/scripts/* /install_ros2/scripts/

# COPY folder.tar.gz /tmp/
# RUN tar -xzvf /tmp/folder.tar.gz -C /destination/folder/

# 检查文件夹是否存在
# RUN if [ -d /install_ros2/scripts ]; then \
#         echo "Folder exists"; \
#     else \
#         echo "Folder does not exist"; \
#     fi

# 运行脚本
# 设置工作目录为 /app/subfolder
WORKDIR /install_ros2/scripts/
# COPY -R ~/install_ros2/scripts/* .
RUN chmod +x main_install_ros2.sh
# CMD ["main_install_ros2.sh"]
# RUN ["main_install_ros2.sh"]  错误
RUN ["./main_install_ros2.sh"]

# 定义容器启动时运行的命令
CMD ["/bin/bash"]

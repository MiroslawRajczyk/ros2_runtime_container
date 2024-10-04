# Use an official ROS 2 Jazzy base image
FROM osrf/ros:jazzy-desktop-full

# Set environment variables
ENV ROS_DISTRO=jazzy
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install necessary dependencies (if any)
RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    git \
    curl \
    openssh-client \
    can-utils \
    nano \
    python3-requests \
    python3-pip \
    python3-colcon-common-extensions \
    ros-$ROS_DISTRO-demo-nodes-cpp \
    ros-$ROS_DISTRO-demo-nodes-py \
    ros-$ROS_DISTRO-rosbridge-suite \
    && rm -rf /var/lib/apt/lists/*

# Set the workspace inside the container
WORKDIR /ros2_ws
RUN mkdir -p src

# Install ROS 2 dependencies and build the workspace (empty here since src will be mounted later)
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install"

# Source the ROS environment automatically when a new shell is opened
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc

# Expose necessary ports for ROS 2
EXPOSE 11311
EXPOSE 9090

# Start the container with a bash shell
CMD ["/bin/bash"]

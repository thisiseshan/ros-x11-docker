# Use the official ROS Noetic base image
FROM ros:noetic

# Install packages needed for RViz and potential dependencies for GUI
RUN apt-get update && apt-get install -y \
    ros-noetic-rviz \
    mesa-utils \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    x11-apps \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for GUI
ENV LIBGL_ALWAYS_SOFTWARE=1
ENV QT_X11_NO_MITSHM=1

# Set up the environment
ENV ROS_WS /opt/ros_ws
RUN mkdir -p $ROS_WS/src
WORKDIR $ROS_WS

# Initialize rosdep
RUN rosdep update

# Copy your ROS package(s) into the container
# COPY ./your_ros_package $ROS_WS/src/your_ros_package

# Source the workspace
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Fix entry point bug
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Default command when running the container
CMD ["bash"]

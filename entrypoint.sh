#!/bin/bash

# Source the ROS environment
source /opt/ros/noetic/setup.bash

# Start roscore in the background
roscore &
# Wait a little for roscore to start
sleep 5
# Execute the Docker CMD
exec "$@"
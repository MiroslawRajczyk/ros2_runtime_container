docker build -t ros2_runtime .

docker run -it --rm --name ros2_runtime \
  --network host \
  -v $(pwd)/ros2_ws_src:/ros2_ws/src \
  ros2_runtime
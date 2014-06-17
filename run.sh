#!/bin/sh

# docker is user root, allow connecting to X
xhost +si:localuser:root

# this will fail because GL
sudo docker run -e DISPLAY=unix$DISPLAY -e LIBGL_DEBUG=verbose -v /tmp/.X11-unix:/tmp/.X11-unix  -v /dev/dri/card0:/dev/dri/card0 -t osmbike/gl-demo

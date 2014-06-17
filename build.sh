#!/bin/sh

git submodule init
git submodule update
sudo docker build -t osmbike/gl-demo .

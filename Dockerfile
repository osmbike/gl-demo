FROM ubuntu:14.04
MAINTAINER Mitja Kleider <mitja@kleider.name>

# Do not ask questions during installation.
ENV DEBIAN_FRONTEND noninteractive

# upgrade packages
RUN apt-get -qq update
RUN apt-get -qqy upgrade

# install base packages
RUN apt-get -qqy install git build-essential zlib1g-dev automake libtool xutils-dev make cmake pkg-config nodejs-legacy curl python

# install C++11 capable GCC
RUN apt-get -qqy install gcc-4.8 g++-4.8

# glfw3 dependencies
RUN apt-get -qqy install libxi-dev libglu1-mesa-dev x11proto-randr-dev x11proto-xext-dev libxrandr-dev x11proto-xf86vidmode-dev libxxf86vm-dev libxcursor-dev

# workaround for build error in curl 7.36.0
# http://sourceforge.net/p/curl/bugs/1350/
# which will not occur if man-db is installed
RUN apt-get -qqy install man-db

# create user account
ENV USER mapuser
ENV HOME /home/mapuser
RUN adduser --disabled-password --gecos "" mapuser
USER mapuser

# add repo
ADD ./mapbox-gl-native /home/mapuser/mapbox-gl-native
WORKDIR /home/mapuser/mapbox-gl-native

RUN make setup
RUN make linux
WORKDIR /home/mapuser/mapbox-gl-native/build/Release

CMD ./mapbox-gl

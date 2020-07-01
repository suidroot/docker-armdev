FROM ubuntu

LABEL maintainer="Ben Mason <locutus@the-collective.net>"
ARG DEBIAN_FRONTEND=noninteractive
ENV SRC_DIR=/usr/src

RUN apt-get update && \
    apt-get install -y build-essential git libusb-1.0 libusb-1.0-0-dev libusb-dev libreadline-dev  \
                       make gawk gcc-arm-none-eabi gdb-multiarch \
                       pkg-config python python3 libftdi-dev curl vim \
                       python3-dev cmake # stlink-tools

#RUN mkdir $SRC_DIR/src; mkdir $SRC_DIR/bin
RUN git clone https://github.com/stlink-org/stlink.git $SRC_DIR/stlink
RUN cd $SRC_DIR/stlink; \
    make release; \
    cd build/Release; make install; \
    /sbin/ldconfig; cd $SRC_DIR; rm -rf $SRC_DIR/src/stlink
RUN apt-get clean

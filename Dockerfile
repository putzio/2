# GCC support can be specified at major, minor, or micro version
# (e.g. 8, 8.2 or 8.2.0).
# See https://hub.docker.com/r/library/gcc/ for all supported GCC
# tags from Docker Hub.
# See https://docs.docker.com/samples/library/gcc/ for more on how to use this image
# this points to the lts version
FROM ubuntu:latest

# wget is needed to get the toolchain, make is needed for builing your 
# projects
RUN apt-get update && apt-get install -y wget make

# add cpio
RUN apt-get install cpio libncurses5 -y

# get the toolchain
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -O gcc-arm-none-eabi.tar.bz2

# unpack the archive to a neatly named target directory
RUN mkdir gcc-arm-none-eabi 
# RUN tar xjfv gcc-arm-none-eabi.tar.bz2 -C gcc-arm-none-eabi --strip-components 1
#install required libraries to upack the gcc-arm-none-eabi files
RUN apt install bzip2 && apt install lbzip2
RUN tar -xvf gcc-arm-none-eabi.tar.bz2 -C gcc-arm-none-eabi
# remove the archive
RUN rm gcc-arm-none-eabi.tar.bz2

# add the tools to the path
ENV PATH="/gcc-arm-none-eabi/bin:${PATH}"

# These commands copy your files into the specified directory in the image
# and set that as the working location
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# This command compiles your app using GCC, adjust for your source code
# RUN make

# This command runs your application, comment out this line to compile only
# CMD ["./myapp"]

LABEL Name=2 Version=0.0.1

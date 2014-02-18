# Based on https://github.com/akisei/dockerfiles/blob/master/oracle-java7/Dockerfile
# See also http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html

# Use Ubuntu 12.04 as the base image
FROM ubuntu:12.04

MAINTAINER Martijn Koster "https://github.com/makuk66"

# Install a bunch of prerequisites
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git-core curl wget python-yaml build-essential libssl-dev

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install java
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
RUN add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y upgrade

# automatically accept oracle license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java7-installer
RUN update-alternatives --display java
# set the java environment variables for when you "bash -l"
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java7-set-default && apt-get clean

# set the JAVA_HOME explicitly
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

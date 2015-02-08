FROM ubuntu:latest

MAINTAINER Yar Kravtsov "https://github.com/yarlson"

RUN \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL="en_US.UTF-8" && \
    echo "Etc/UTC" | sudo tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    apt-get update && \
    apt-get upgrade -y && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install oracle-java7-installer -y && \
    update-java-alternatives -s java-7-oracle && \
    rm -fr /var/cache/oracle-jdk7-installer  && \
    apt-get clean && \
    apt-get autoremove

ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
ENV LANGUAGE   en_US:en

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

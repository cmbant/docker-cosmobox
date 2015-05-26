FROM ubuntu:15.04

MAINTAINER Antony Lewis

RUN apt-get update \
 && apt-get install -y \
     bison \
     build-essential \
     flex \
     g++ \
     git \
     libmpc-dev \
 && apt-get clean


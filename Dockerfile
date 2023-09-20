FROM ubuntu:22.04

RUN apt -y update && \
    apt -y install python3 python3-dev python3-pip build-essential

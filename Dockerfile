FROM openjdk:11
RUN apt-get update; \
    apt-get install -y iptables curl npm
COPY . /app
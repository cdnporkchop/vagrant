#!/usr/bin/env bash
IP=$(ip a s eth1 | awk '/inet / {print $2}' | sed -e 's/\/..//g')

apt-get update

sudo apt-get install -y redis-server

#  sudo mv /etc/redis/redis.conf /etc/redis/redis.conf.old
#  echo "bind 0.0.0.0" | sudo tee /etc/redis/redis.conf
#  cat /etc/redis/redis.conf.old | grep -v bind | sudo tee -a /etc/redis/redis.conf

echo "PING"
redis-cli ping

#Remind you what the IP of the Vagrant is and default ports
echo Redis Server @: "${IP}:${DEFAULT_PORT}"  
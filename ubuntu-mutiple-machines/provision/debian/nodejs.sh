#!/usr/bin/env bash
IP=$(ip a s eth1 | awk '/inet / {print $2}' | sed -e 's/\/..//g')

apt-get update

curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -

sudo apt-get install --yes nodejs

#Remind you what the IP of the Vagrant is and default ports
echo NodeJS @: "${IP}:${DEFAULT_PORT}"  
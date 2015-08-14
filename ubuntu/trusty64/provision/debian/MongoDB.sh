#!/usr/bin/env bash
IP=$(ip a s eth1 | awk '/inet / {print $2}' | sed -e 's/\/..//g')
DEFAULT_PORT=27017  #/etc/mongod.conf, 27017 

sudo apt-get update

#http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
#
#Import the public key used by the package management system.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

#Create a list file for MongoDB.
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

#Reload local package database.
sudo apt-get update

#Install the latest stable version of MongoDB.
sudo apt-get install -y mongodb-org
#Install a specific release of MongoDB.
#sudo apt-get install -y mongodb-org=3.0.5 mongodb-org-server=3.0.5 mongodb-org-shell=3.0.5 mongodb-org-mongos=3.0.5 mongodb-org-tools=3.0.5

#Pin a specific version of MongoDB.
#echo "mongodb-org hold" | sudo dpkg --set-selections
#echo "mongodb-org-server hold" | sudo dpkg --set-selections
#echo "mongodb-org-shell hold" | sudo dpkg --set-selections
#echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
#echo "mongodb-org-tools hold" | sudo dpkg --set-selections

#Comment out the bind_ip configuration set that defaults to bind_ip = 127.0.0.1
sudo service mongod stop
sudo sed -i 's/bind_ip/#bind_ip/g' /etc/mongod.conf

#Start MongoDB.
sudo service mongod start

#Remind you what the IP of the Vagrant is and Default port
echo MongoDB @: "${IP}:${DEFAULT_PORT}"

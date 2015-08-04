#!/usr/bin/env bash
IP=$(ip a s eth1 | awk '/inet / {print $2}' | sed -e 's/\/..//g')
DEFAULT_PORT=15672
DEFAULT_USR=rabbitmq
DEFAULT_PWD=rabbitmq
RABBITMQ_DEB=rabbitmq-server_3.5.4-1_all.deb
RABBITMQ_URL='http://www.rabbitmq.com/releases/rabbitmq-server/v3.5.4/$RABBITMQ_DEB'


apt-get update

sudo apt-get -y install erlang
sudo apt-get -y install erlang-nox

#Fetch the DEB file from the RabbitMQ Website and install
wget -O $RABBITMQ_DEB $RABBITMQ_URL
sudo dpkg -i $RABBITMQ_DEB

#Remove the downloaded tar file
rm $RABBITMQ_DEB

#Configure it so default can login from remote, or just add a new admin user
sudo gunzip /usr/share/doc/rabbitmq-server/rabbitmq.config.example.gz > /etc/rabbitmq/rabbitmq.config
echo '[{rabbit, [{loopback_users, []}]}].' >> /etc/rabbitmq/rabbitmq.config
echo 'NODENAME=@DEFAULT_USR@$IP' >> /etc/rabbitmq/rabbitmq.config

rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
rabbitmq-plugins list

#Create a new Administrative user
sudo rabbitmqctl add_user $DEFAULT_USR $DEFAULT_PWD
sudo rabbitmqctl set_user_tags $DEFAULT_USR administrator

#Remind you what the IP of the Vagrant is and Splunk's port
echo RabbitMQ Web UI @: "${IP}:${DEFAULT_PORT}"  $DEFAULT_USR/$DEFAULT_PWD
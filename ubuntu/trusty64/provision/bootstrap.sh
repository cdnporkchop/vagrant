#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
	sudo rm -rf /var/www/html
	#sudo ln -fs /vagrant/public /var/www/html
	ln -s /vagrant /var/www
fi

service apache2 start

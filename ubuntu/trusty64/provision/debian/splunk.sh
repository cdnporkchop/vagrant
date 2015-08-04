#!/usr/bin/env bash
SPLUNK_TGZ=splunk-6.2.4-271043-Linux-x86_64.tgz
SPLUNK_URL='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=Linux&version=6.2.4&product=splunk&filename=splunk-6.2.4-271043-Linux-x86_64.tgz&wget=true'
SPLUNK_DEFAULTPORT=8000
IP=$(ip -f inet a | grep eth1 | awk '/inet / { print $2 }')

apt-get update

#Fetch the Tar file from the Spunk Website
wget -O $SPLUNK_TGZ $SPLUNK_URL

#Uncompress so that it will eventually be in /opt/splunk
tar xvzf $SPLUNK_TGZ -C /opt

#Remove the downloaded tar file
rm $SPLUNK_TGZ

#Start splunk
sudo /opt/splunk/bin/splunk start --accept-license

#Remind you what the IP of the Vagrant is and Splunk's port
echo Splunk @: "${IP}:${SPLUNK_DEFAULTPORT}"

#Some alternate www.commandlinefu.com for IP lookups
#IP=$(ifconfig eth1 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')
#IP=$(ip a s eth0 | awk '/inet / {print $2} | sed -e 's/\/..//g')
#!/usr/bin/env bash
IP=$(ip -f inet a | grep eth1 | awk '/inet / { print $2 }')
SPLUNK_PORT=8000
SPLUNK_TGZ=splunk-6.2.4-271043-Linux-x86_64.tgz
SPLUNK_URL='https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=Linux&version=6.2.4&product=splunk&filename=splunk-6.2.4-271043-Linux-x86_64.tgz&wget=true'


apt-get update

wget -O $SPLUNK_TGZ $SPLUNK_URL

tar xvzf $SPLUNK_TGZ -C /opt
rm $SPLUNK_TGZ

sudo /opt/splunk/bin/splunk start --accept-license

echo Splunk is available: "${IP}:${PORT}"

#IP=$(ifconfig eth1 | sed -ne 's/.*inet addr:\([0-9.]\+\) .*/\1/p')
#IP=$(ip a s eth0 | awk '/inet / {print $2} | sed -e 's/\/..//g')
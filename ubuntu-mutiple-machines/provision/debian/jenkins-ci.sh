#!/usr/bin/env bash
IP=$(ip a s eth1 | awk '/inet / {print $2}' | sed -e 's/\/..//g')
JENKINS_CI_URL=http://pkg.jenkins-ci.org/debian
JENKINS_CI_URL_KEY=$JENKINS_CI_URL/jenkins-ci.org.key
JENKINS_CI_PORT=8080

sudo apt-get update

#Fetch Jenkin files
sudo wget -q -O - $JENKINS_CI_URL_KEY | sudo apt-key add -
sudo sh -c "echo deb ${JENKINS_CI_URL} binary/ > /etc/apt/sources.list.d/jenkins.list"

sudo apt-get update
sudo apt-get install -y jenkins
sudo service jenkins start

sudo curl  -L http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' | curl -X POST -H 'Accept: application/json' -d @- http://localhost:8080/updateCenter/byId/default/postBack


#Remind you what the IP of the Vagrant is and Default port
echo Jenkins-CI @: "${IP}:${JENKINS_CI_PORT}"

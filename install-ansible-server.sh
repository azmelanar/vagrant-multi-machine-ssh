#!/usr/bin/env bash

set -e

# install required packages for docker
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# add repository with docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# install docker
apt-get update

apt-get install -y docker-ce

# add ansible user
useradd -m -s /bin/bash -d /home/ansible ansible

# generate ssh key for ansible user
runuser -l ansible -c "ssh-keygen -t rsa -b 4096 -C 'ansible' -N '' -f /home/ansible/.ssh/id_rsa -q"

# copy key to git server
runuser -l ansible -c "cat ~/.ssh/id_rsa.pub | ssh -i /vagrant/ssh/id_rsa -o StrictHostKeyChecking=no git@192.168.16.101 'mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys'"

# clone repository with ssh public keys from git server
runuser -l ansible -c "git clone git@192.168.16.101:repos/ssh-public-keys.git ssh-public-keys"

# add permissions for docker to ansible user
usermod -a -G docker ansible

# checking docker service
systemctl start docker.service
systemctl enable docker.service

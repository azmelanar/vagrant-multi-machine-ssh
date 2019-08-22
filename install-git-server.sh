#!/usr/bin/env bash

set -e

# add git user
useradd -m -s /bin/bash -d /home/git git

# add admin ssh key for git user
runuser -l git -c "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat /vagrant/ssh/id_rsa.pub >> ~/.ssh/authorized_keys"

# create a repo for ssh public keys
runuser -l git -c "git init --bare /home/git/repos/ssh-public-keys.git"

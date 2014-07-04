#!/usr/bin/env bash

PROJECT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get remove -y openjdk-6-jre
sudo apt-get install -y openjdk-7-jre

sudo apt-get install -y build-essential nodejs libsqlite3-dev

sudo apt-get remove -y ruby1.9 ruby1.9.1
sudo apt-get install -y ruby2.1 ruby2.1-dev

sudo gem install bundle

pushd $PROJECT_FOLDER &> /dev/null
bundle install
popd &> /dev/null

sudo mkdir -p /opt/od4d
sudo chown $USER: /opt/od4d

sudo mkdir -p /var/log/od4d
sudo chown $USER: /var/log/od4d

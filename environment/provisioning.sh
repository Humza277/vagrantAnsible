#!/bin/bash

sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt-get install git -y
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash

sudo apt-get install nodejs -y
sudo apt-get update -y
sudo npm install pm2 -y
sudo apt-get update -y

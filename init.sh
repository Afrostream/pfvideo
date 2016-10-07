#!/bin/sh

git clone https://afrostream-tech:d51e355769ddd0fd212084c35fb99f71ab4146b2@github.com/Afrostream/pfscheduler.git
git clone https://afrostream-tech:d51e355769ddd0fd212084c35fb99f71ab4146b2@github.com/Afrostream/pfencoder.git
mkdir data
docker-compose build

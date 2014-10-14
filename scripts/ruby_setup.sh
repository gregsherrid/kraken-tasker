#!/bin/bash

sudo apt-get update -y
sudo apt-get install build-essential -y
sudo apt-get install libxslt-dev libxml2-dev -y
sudo apt-get install ruby -y
sudo apt-get install bundler -y
bundle install
#!/bin/bash
set -e

apt-get update -y
apt-get upgrade -y

apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    vim \
    htop \
    net-tools

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

node -v
npm -v

apt-get clean
rm -rf /var/lib/apt/lists/*

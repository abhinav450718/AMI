#!/bin/bash
set -e

apt-get update -y
apt-get upgrade -y

# Install whatever your app needs
apt-get install -y curl git unzip

# Example: install Node
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

echo "AMI setup complete"

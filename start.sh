#!/bin/bash
sudo yum update -y
sudo yum install git -y
git clone https://github.com/thekindlyone/qrious-project.git ~/project
sudo chmod +x ~/project/scripts/*.sh
~/project/scripts/install.sh
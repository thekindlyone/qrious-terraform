#!/bin/bash

yum update -y
yum install git -y
sudo -u ec2-user git clone https://github.com/thekindlyone/qrious-project.git /home/ec2-user/project
sudo -u ec2-user sudo chmod +x /home/ec2-user/project/scripts/*.sh
sudo -u ec2-user /home/ec2-user/project/scripts/install.sh